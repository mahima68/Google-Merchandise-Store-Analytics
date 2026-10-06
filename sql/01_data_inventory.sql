-- Data inventory for Google's public GA4 ecommerce sample.
-- Source period: 2020-11-01 through 2021-01-31 (UTC event_date).
-- This is a separate obfuscated sample, not the user's 2026 GA4 screenshots.
SELECT
  MIN(PARSE_DATE('%Y%m%d', event_date)) AS first_event_date,
  MAX(PARSE_DATE('%Y%m%d', event_date)) AS last_event_date,
  COUNT(*) AS event_rows,
  COUNT(DISTINCT user_pseudo_id) AS pseudonymous_users,
  COUNT(DISTINCT event_name) AS event_types,
  COUNTIF(event_name = 'purchase') AS purchase_event_rows,
  COUNTIF(event_name = 'view_item') AS view_item_event_rows,
  COUNTIF(event_name = 'add_to_cart') AS add_to_cart_event_rows,
  COUNTIF(event_name = 'begin_checkout') AS begin_checkout_event_rows
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';

-- Event coverage and missing pseudonymous IDs.
SELECT
  event_name,
  COUNT(*) AS event_rows,
  COUNTIF(user_pseudo_id IS NULL) AS rows_missing_user_pseudo_id,
  COUNT(DISTINCT user_pseudo_id) AS distinct_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY event_name
ORDER BY event_rows DESC;
