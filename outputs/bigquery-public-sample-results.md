# BigQuery public sample — executed results

## Provenance and scope

- Source: `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
- Date range: **2020-11-01 to 2021-01-31** (table suffixes `20201101`–`20210131`)
- Google Cloud project used to run queries: **GMS Analytics** (`gms-analytics-510721`)
- Execution mode: BigQuery **Sandbox**; paid trial not started and billing not enabled
- This is Google's separate, obfuscated public sample. These results do **not** reproduce or combine with the 2026 GA4 screenshots in this case study.

## Query log and captured results

| Analysis | Status | Scan estimate | Captured result |
|---|---|---:|---|
| Data inventory | Completed | 179.02 MB | 4,295,584 event rows; 270,154 distinct pseudonymous users; 17 event names; dates 20201101–20210131 |
| Acquisition by first-user source/medium | Completed and re-run | 223 MB | 12 source/medium rows returned. Latest executed results by purchase revenue: `google / organic` (1,484 purchase events; $86,645), `(direct) / (none)` (1,211; $79,196), `(data deleted) / (data deleted)` (760; $54,128), and `shop.googlemerchandisestore.com / referral` (708; $47,318). The latest query result is authoritative for this report; do not use older transcribed counts. |
| Product performance | Completed (corrected product-name aggregation; revenue, units, and views rankings) | 218.87 MB | Top 10 rows for each ranking returned in one run. Grouping by item name combines records whose item IDs differ across events; ID counts are retained as a QA signal. |
| Ordered session funnel | Completed (revised sequential logic) | 1.04 GB for temp-table step; 1.79 MB for final breakdown (processed) | Overall, device, and country results captured below. |
| Device/geography segmentation | Completed | 221.29 MB | 20 device/country combinations returned; leading user segments captured below. |

### Leading device/country segments by distinct users

| Device | Country | Users |
|---|---|---:|
| Desktop | United States | 69,827 |
| Mobile | United States | 47,775 |
| Desktop | India | 14,918 |
| Desktop | Canada | 11,904 |
| Mobile | India | 10,223 |

The visible result view captured these leading rows and the distinct-user/session-start columns. It did not preserve the purchase and revenue columns, so no device/country purchase or revenue ranking is reported here.

### Product performance rankings (aggregated by item name)

The first query grouped by both item ID and name. That split named products across different IDs in the export, so view and purchase metrics appeared disconnected. The corrected query groups by **item name**, counts distinct IDs as a QA signal, and returns top 10 by revenue, units purchased, and item views. One completed BigQuery run processed **218.87 MB**. Items purchased are units, not orders.

#### Top 10 by item revenue

| Rank | Product | Views | Cart additions | Units purchased | Item revenue (USD) |
|---:|---|---:|---:|---:|---:|
| 1 | Google Zip Hoodie F/C | 49,795 | 13,011 | 273 | $13,788 |
| 2 | Google Crewneck Sweatshirt N… | 32,271 | 10,631 | 236 | $10,714 |
| 3 | Google Men's Tech Fleece Grey | 17,371 | 5,785 | 134 | $9,965 |
| 4 | Google Badge Heavyweight Pull… | 33,602 | 10,139 | 201 | $9,712 |
| 5 | Super G Unisex Joggers | 52,758 | 12,015 | 308 | $9,529 |
| 6 | Google Crewneck Sweatshirt Gr… | 28,084 | 8,494 | 184 | $8,382 |
| 7 | Google Sherpa Zip Hoodie Char… | 32,219 | 5,837 | 115 | $6,397 |
| 8 | Google Men's Puff Jacket Black | 11,405 | 2,379 | 64 | $6,187 |
| 9 | Google Men's Tech Fleece Vest… | 4,328 | 886 | 84 | $5,549 |
| 10 | Google Women's Puff Jacket Bl… | 13,860 | 3,185 | 57 | $5,313 |

#### Top 10 by units purchased

| Rank | Product | Units purchased |
|---:|---|---:|
| 1 | Google Clear Pen 4-Pack | 444 |
| 2 | Google Laptop and Cell Phone… | 416 |
| 3 | Google Metallic Notebook Set | 365 |
| 4 | Google Pen White | 340 |
| 5 | Google Camp Mug Ivory | 300 |
| 6 | Google Decal | 289 |
| 7 | Google Canteen Bottle Black | 268 |
| 8 | Google Heathered Pom Beanie | 261 |
| 9 | Keyboard DOT Sticker | 238 |
| 10 | Maze Pen | 224 |

#### High item views with relatively few units purchased

| Product | Item views | Units purchased | Units per item-view event |
|---|---:|---:|---:|
| Google Women's Striped L/S | 42,142 | 0 | 0.00% |
| Google F/C Long Sleeve Tee Ch… | 34,275 | 0 | 0.00% |
| Google Campus Bike Eco Tee N… | 43,140 | 56 | 0.13% |
| Google Tee Yellow | 34,873 | 39 | 0.11% |

These ratios are **units per item-view event**, not unique-shopper conversion rates. They are screening signals, not causal explanations. Several item names were clipped in the visible result grid; ellipses are preserved rather than completed by guesswork. The result query also reports a distinct item-ID count because the same name appears with multiple IDs in the public export.

### Ordered session funnel

The revised query builds sessions from user_pseudo_id + ga_session_id, then finds each next event strictly after the preceding step. It counts each session at most once per step. This is a session-based custom funnel, not GA4's user-based Funnel Exploration.

| Step | Sessions reaching step | Step-to-step continuation |
|---|---:|---:|
| view_item | 77,020 | — |
| add_to_cart | 14,380 | 18.67% from view |
| begin_checkout | 5,187 | 36.07% from cart |
| purchase | 2,778 | 53.56% from checkout |

Overall, **3.61%** of sessions with a product view reached an ordered purchase in the same session.

#### Funnel by device category

| Device | View | Add to cart | Begin checkout | Purchase | Checkout → purchase |
|---|---:|---:|---:|---:|---:|
| Desktop | 44,819 | 8,303 | 2,975 | 1,567 | 52.67% |
| Mobile | 30,501 | 5,773 | 2,101 | 1,150 | 54.74% |
| Tablet | 1,700 | 304 | 111 | 61 | 54.95% |

#### Leading countries by view sessions

| Country | View | Add to cart | Begin checkout | Purchase | Checkout → purchase |
|---|---:|---:|---:|---:|---:|
| United States | 33,921 | 6,364 | 2,282 | 1,225 | 53.68% |
| India | 7,264 | 1,329 | 473 | 256 | 54.12% |
| Canada | 5,852 | 1,130 | 424 | 226 | 53.30% |
| United Kingdom | 2,400 | 446 | 157 | 91 | 57.96% |

These are the highest-volume country rows captured, not all countries. The revised script also returns remaining countries. Rates are public-sample session ratios, and small segments should be treated cautiously. Do not compare these figures directly with the GA4 screenshot funnel, which differs in dataset, time window, identity, and exploration configuration.


## Reproducibility and limitations

The companion SQL files are in `sql/`. The product query was corrected to group by item name and now returns ranked outputs for revenue, units, and views. Remaining limitations: only the top 10 product rows per ranking are shown, some product names were clipped in the result grid, and complete device/country purchase and revenue outputs were not preserved. The public sample is obfuscated and differs from the GA4 demo property's reports.
