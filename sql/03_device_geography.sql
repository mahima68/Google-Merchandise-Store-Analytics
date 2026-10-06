-- Ranked device and geography segments for the public GA4 sample.
-- Runs separate device, country, and device/country summaries with purchase outcomes.
WITH event_base AS (
  SELECT
    user_pseudo_id,
    event_name,
    COALESCE(device.category, '(not set)') AS device_category,
    COALESCE(geo.country, '(not set)') AS country,
    ecommerce.purchase_revenue_in_usd
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
),
segments AS (
  SELECT
    'device' AS breakdown,
    device_category AS segment,
    '(all countries)' AS secondary_segment,
    COUNT(DISTINCT user_pseudo_id) AS users,
    COUNTIF(event_name = 'session_start') AS session_start_events,
    COUNTIF(event_name = 'purchase') AS purchase_events,
    SUM(IF(event_name = 'purchase', COALESCE(purchase_revenue_in_usd, 0), 0)) AS purchase_revenue_usd
  FROM event_base
  GROUP BY device_category
  UNION ALL
  SELECT
    'country',
    country,
    '(all devices)',
    COUNT(DISTINCT user_pseudo_id),
    COUNTIF(event_name = 'session_start'),
    COUNTIF(event_name = 'purchase'),
    SUM(IF(event_name = 'purchase', COALESCE(purchase_revenue_in_usd, 0), 0))
  FROM event_base
  GROUP BY country
  UNION ALL
  SELECT
    'device_country',
    device_category,
    country,
    COUNT(DISTINCT user_pseudo_id),
    COUNTIF(event_name = 'session_start'),
    COUNTIF(event_name = 'purchase'),
    SUM(IF(event_name = 'purchase', COALESCE(purchase_revenue_in_usd, 0), 0))
  FROM event_base
  GROUP BY device_category, country
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY breakdown ORDER BY users DESC, segment, secondary_segment) AS rank
  FROM segments
)
SELECT *
FROM ranked
WHERE rank <= 10
ORDER BY breakdown, rank;
