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
| Acquisition by first-user source/medium | Completed | 223 MB | 12 source/medium rows returned. Top rows by purchase revenue included `google / organic` (103,487 users; 1,454 purchase events), `(direct) / (none)` (75,951; 1,251), `(data deleted) / (data deleted)` (17,948; 830), and Google Merchandise Store referral (26,065; 701). Revenue values were not captured in the saved screen notes, so no revenue ranking or amount is stated here. |
| Product performance | Completed | 162.66 MB | Top revenue products captured below. |
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

### Top products by item revenue (captured rows)

| Product (visible name) | Units purchased | Item revenue (USD) | Item-view events | Add-to-cart events |
|---|---:|---:|---:|---:|
| Google Zip Hoodie F/C | 273 | $13,788 | 49,795 | 13,011 |
| Google Crewneck Sweatshirt N… | 236 | $10,714 | 32,271 | 10,631 |
| Google Men's Tech Fleece Grey | 134 | $9,965 | 17,371 | 5,785 |
| Google Badge Heavyweight Pull… | 201 | $9,712 | 33,602 | 10,139 |
| Super G Unisex Joggers | 308 | $9,529 | 52,758 | 12,015 |

Names containing an ellipsis were clipped in the captured BigQuery result view and are intentionally not expanded by guesswork. `units_purchased` counts item units, not orders.

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

The companion SQL files are in `sql/`. Query results above are only as complete as the visible results captured during the BigQuery runs.  In particular, the acquisition result's revenue cells and the full product list were not preserved in this note. Run or reopen those saved queries if those exact values are needed. The public sample has obfuscated data and differs from the GA4 demo property's reports.
