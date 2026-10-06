-- User, engagement, device, and geography summaries.
-- Engagement events/session criteria are approximated at user level here; use GA4 UI
-- for exact reporting parity and document any differences.
SELECT
  device.category AS device_category,
  geo.country AS country,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'session_start') AS session_start_events,
  COUNTIF(event_name = 'purchase') AS purchase_events,
  SUM(IF(event_name = 'purchase', COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)) AS purchase_revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY 1, 2
ORDER BY users DESC;

-- Country rollup to identify missing geo attribution separately.
SELECT
  COALESCE(geo.country, '(not set)') AS country,
  COUNT(DISTINCT user_pseudo_id) AS users,
  SUM(IF(event_name = 'purchase', COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)) AS purchase_revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY 1
ORDER BY users DESC;
