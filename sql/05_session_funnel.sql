-- Ordered, same-session funnel using user_pseudo_id + ga_session_id.
-- A session reaches a step only when its event timestamp follows the prior step.
-- This is a session funnel, not GA4's user-based Funnel Exploration metric.
WITH relevant_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
    event_timestamp,
    event_name,
    device.category AS device_category,
    geo.country AS country,
    traffic_source.source AS first_user_source,
    traffic_source.medium AS first_user_medium
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
    AND user_pseudo_id IS NOT NULL
),
session_steps AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    ANY_VALUE(device_category) AS device_category,
    ANY_VALUE(country) AS country,
    ANY_VALUE(first_user_source) AS first_user_source,
    ANY_VALUE(first_user_medium) AS first_user_medium,
    MIN(IF(event_name = 'view_item', event_timestamp, NULL)) AS view_item_ts,
    MIN(IF(event_name = 'add_to_cart', event_timestamp, NULL)) AS add_to_cart_ts,
    MIN(IF(event_name = 'begin_checkout', event_timestamp, NULL)) AS begin_checkout_ts,
    MIN(IF(event_name = 'purchase', event_timestamp, NULL)) AS purchase_ts
  FROM relevant_events
  WHERE ga_session_id IS NOT NULL
  GROUP BY user_pseudo_id, ga_session_id
),
ordered_funnel AS (
  SELECT
    *,
    view_item_ts IS NOT NULL AS reached_view_item,
    view_item_ts IS NOT NULL AND add_to_cart_ts >= view_item_ts AS reached_add_to_cart,
    view_item_ts IS NOT NULL
      AND add_to_cart_ts >= view_item_ts
      AND begin_checkout_ts >= add_to_cart_ts AS reached_begin_checkout,
    view_item_ts IS NOT NULL
      AND add_to_cart_ts >= view_item_ts
      AND begin_checkout_ts >= add_to_cart_ts
      AND purchase_ts >= begin_checkout_ts AS reached_purchase
  FROM session_steps
)
SELECT
  COUNTIF(reached_view_item) AS sessions_view_item,
  COUNTIF(reached_add_to_cart) AS sessions_add_to_cart,
  COUNTIF(reached_begin_checkout) AS sessions_begin_checkout,
  COUNTIF(reached_purchase) AS sessions_purchase,
  SAFE_DIVIDE(COUNTIF(reached_add_to_cart), COUNTIF(reached_view_item)) AS view_to_cart_rate,
  SAFE_DIVIDE(COUNTIF(reached_begin_checkout), COUNTIF(reached_add_to_cart)) AS cart_to_checkout_rate,
  SAFE_DIVIDE(COUNTIF(reached_purchase), COUNTIF(reached_begin_checkout)) AS checkout_to_purchase_rate
FROM ordered_funnel;

-- Device/country segment: change the SELECT to include device_category or country,
-- then GROUP BY that dimension. The same ordered flags/denominators must be retained.
-- Channel comparison must use a session-scoped source/medium field, not first-user
-- traffic_source. Confirm the export schema before defining a session channel.
