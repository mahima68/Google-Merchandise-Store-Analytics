-- First-user acquisition, not session channel attribution.
-- traffic_source is the GA4 export's first-user acquisition source.
WITH user_acquisition AS (
  SELECT
    user_pseudo_id,
    ANY_VALUE(traffic_source.source) AS first_user_source,
    ANY_VALUE(traffic_source.medium) AS first_user_medium,
    ANY_VALUE(traffic_source.name) AS first_user_campaign,
    COUNTIF(event_name = 'session_start') AS observed_sessions,
    COUNTIF(event_name = 'purchase') AS purchase_events,
    SUM(IF(event_name = 'purchase', COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)) AS purchase_revenue_usd
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND user_pseudo_id IS NOT NULL
  GROUP BY user_pseudo_id
)
SELECT
  COALESCE(first_user_source, '(not set)') AS first_user_source,
  COALESCE(first_user_medium, '(not set)') AS first_user_medium,
  COUNT(*) AS users,
  SUM(observed_sessions) AS observed_sessions,
  SUM(purchase_events) AS purchase_events,
  SUM(purchase_revenue_usd) AS purchase_revenue_usd,
  SAFE_DIVIDE(COUNTIF(purchase_events > 0), COUNT(*)) AS user_purchase_rate
FROM user_acquisition
GROUP BY 1, 2
ORDER BY purchase_revenue_usd DESC;

-- Session-level source/medium can only be analyzed from session-scoped traffic fields.
-- Do not substitute traffic_source.source/medium and label it session attribution.
-- Inspect schema/availability of collected_traffic_source before adding that analysis.
