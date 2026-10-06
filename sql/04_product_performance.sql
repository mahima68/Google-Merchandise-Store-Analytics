-- Product-level performance for the public GA4 sample (2020-11-01 to 2021-01-31).
-- Aggregate by item_name: in this export, item_id can differ across records for the same named product.
-- Keep distinct item_id counts as a QA signal. Items purchased means units, not orders.
WITH item_events AS (
  SELECT
    event_name,
    item.item_id,
    item.item_name,
    item.quantity,
    item.item_revenue_in_usd,
    item.price_in_usd
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  CROSS JOIN UNNEST(items) AS item
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN ('view_item', 'add_to_cart', 'purchase')
),
product_metrics AS (
  SELECT
    COALESCE(item_name, '(not set)') AS item_name,
    COUNT(DISTINCT item_id) AS item_id_count,
    COUNTIF(event_name = 'view_item') AS item_view_rows,
    COUNTIF(event_name = 'add_to_cart') AS item_cart_rows,
    SUM(IF(event_name = 'purchase', COALESCE(quantity, 0), 0)) AS units_purchased,
    SUM(IF(event_name = 'purchase', COALESCE(item_revenue_in_usd, price_in_usd * quantity, 0), 0)) AS item_revenue_usd
  FROM item_events
  GROUP BY 1
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY item_revenue_usd DESC, item_name) AS revenue_rank,
    ROW_NUMBER() OVER (ORDER BY units_purchased DESC, item_name) AS units_rank,
    ROW_NUMBER() OVER (ORDER BY item_view_rows DESC, item_name) AS views_rank
  FROM product_metrics
)
SELECT
  'Revenue' AS ranking,
  revenue_rank AS rank,
  item_name,
  item_id_count,
  item_view_rows,
  item_cart_rows,
  units_purchased,
  item_revenue_usd
FROM ranked
WHERE revenue_rank <= 10
UNION ALL
SELECT
  'Units purchased',
  units_rank,
  item_name,
  item_id_count,
  item_view_rows,
  item_cart_rows,
  units_purchased,
  item_revenue_usd
FROM ranked
WHERE units_rank <= 10
UNION ALL
SELECT
  'Item views',
  views_rank,
  item_name,
  item_id_count,
  item_view_rows,
  item_cart_rows,
  units_purchased,
  item_revenue_usd
FROM ranked
WHERE views_rank <= 10
ORDER BY ranking, rank;
