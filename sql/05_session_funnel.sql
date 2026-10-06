-- Ordered, same-session funnel using user_pseudo_id + ga_session_id.
-- A session advances only when each next event occurs strictly after the prior step.
-- This is session-based and not GA4's user-based Funnel Exploration metric.
-- Run the whole file as a BigQuery script. It creates a temporary table, then returns
-- one combined result set for overall, device-category, and country breakdowns.
CREATE TEMP TABLE ordered_funnel AS
WITH relevant_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS ga_session_id,
    event_timestamp,
    event_name,
    device.category AS device_category,
    geo.country AS country
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
    AND user_pseudo_id IS NOT NULL
),
session_events AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    ANY_VALUE(device_category) AS device_category,
    ANY_VALUE(country) AS country,
    ARRAY_AGG(STRUCT(event_timestamp, event_name) ORDER BY event_timestamp) AS events
  FROM relevant_events
  WHERE ga_session_id IS NOT NULL
  GROUP BY user_pseudo_id, ga_session_id
),
view_step AS (
  SELECT
    *,
    (SELECT MIN(e.event_timestamp) FROM UNNEST(events) e WHERE e.event_name = 'view_item') AS view_item_ts
  FROM session_events
),
cart_step AS (
  SELECT
    *,
    (SELECT MIN(e.event_timestamp) FROM UNNEST(events) e
      WHERE e.event_name = 'add_to_cart' AND e.event_timestamp > view_item_ts) AS add_to_cart_ts
  FROM view_step
),
checkout_step AS (
  SELECT
    *,
    (SELECT MIN(e.event_timestamp) FROM UNNEST(events) e
      WHERE e.event_name = 'begin_checkout' AND e.event_timestamp > add_to_cart_ts) AS begin_checkout_ts
  FROM cart_step
),
purchase_step AS (
  SELECT
    *,
    (SELECT MIN(e.event_timestamp) FROM UNNEST(events) e
      WHERE e.event_name = 'purchase' AND e.event_timestamp > begin_checkout_ts) AS purchase_ts
  FROM checkout_step
)
SELECT
  user_pseudo_id,
  ga_session_id,
  device_category,
  country,
  view_item_ts IS NOT NULL AS reached_view_item,
  add_to_cart_ts IS NOT NULL AS reached_add_to_cart,
  begin_checkout_ts IS NOT NULL AS reached_begin_checkout,
  purchase_ts IS NOT NULL AS reached_purchase
FROM purchase_step;

SELECT
  'overall' AS breakdown,
  'All sessions' AS segment,
  COUNTIF(reached_view_item) AS sessions_view_item,
  COUNTIF(reached_add_to_cart) AS sessions_add_to_cart,
  COUNTIF(reached_begin_checkout) AS sessions_begin_checkout,
  COUNTIF(reached_purchase) AS sessions_purchase,
  SAFE_DIVIDE(COUNTIF(reached_add_to_cart), COUNTIF(reached_view_item)) AS view_to_cart_rate,
  SAFE_DIVIDE(COUNTIF(reached_begin_checkout), COUNTIF(reached_add_to_cart)) AS cart_to_checkout_rate,
  SAFE_DIVIDE(COUNTIF(reached_purchase), COUNTIF(reached_begin_checkout)) AS checkout_to_purchase_rate
FROM ordered_funnel

UNION ALL

SELECT
  'device_category',
  COALESCE(device_category, '(not set)'),
  COUNTIF(reached_view_item),
  COUNTIF(reached_add_to_cart),
  COUNTIF(reached_begin_checkout),
  COUNTIF(reached_purchase),
  SAFE_DIVIDE(COUNTIF(reached_add_to_cart), COUNTIF(reached_view_item)),
  SAFE_DIVIDE(COUNTIF(reached_begin_checkout), COUNTIF(reached_add_to_cart)),
  SAFE_DIVIDE(COUNTIF(reached_purchase), COUNTIF(reached_begin_checkout))
FROM ordered_funnel
GROUP BY device_category

UNION ALL

SELECT
  'country',
  COALESCE(country, '(not set)'),
  COUNTIF(reached_view_item),
  COUNTIF(reached_add_to_cart),
  COUNTIF(reached_begin_checkout),
  COUNTIF(reached_purchase),
  SAFE_DIVIDE(COUNTIF(reached_add_to_cart), COUNTIF(reached_view_item)),
  SAFE_DIVIDE(COUNTIF(reached_begin_checkout), COUNTIF(reached_add_to_cart)),
  SAFE_DIVIDE(COUNTIF(reached_purchase), COUNTIF(reached_begin_checkout))
FROM ordered_funnel
GROUP BY country
ORDER BY breakdown, sessions_view_item DESC;
