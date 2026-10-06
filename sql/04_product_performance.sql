-- Product views, cart additions, units purchased, and item revenue.
-- Items purchased is item quantity; it is not the number of orders.
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
)
SELECT
  COALESCE(item_id, '(not set)') AS item_id,
  COALESCE(item_name, '(not set)') AS item_name,
  COUNTIF(event_name = 'view_item') AS item_view_rows,
  COUNTIF(event_name = 'add_to_cart') AS item_cart_rows,
  SUM(IF(event_name = 'purchase', COALESCE(quantity, 0), 0)) AS units_purchased,
  SUM(IF(event_name = 'purchase', COALESCE(item_revenue_in_usd, price_in_usd * quantity, 0), 0)) AS item_revenue_usd,
  SAFE_DIVIDE(
    SUM(IF(event_name = 'purchase', COALESCE(quantity, 0), 0)),
    COUNTIF(event_name = 'view_item')
  ) AS units_purchased_per_item_view
FROM item_events
GROUP BY 1, 2
ORDER BY item_revenue_usd DESC;

-- Sort the same output by units_purchased in the UI to answer most frequently
-- purchased; by item_revenue_usd to answer highest revenue.
