# Google Merchandise Store Analytics — Project Progress and Data Report

## Project goal

Analyze how visitors arrive at the Google Merchandise Store, how they engage, which products attract and convert shoppers, where the purchase journey loses users, and what actions the business should investigate. The portfolio work combines GA4 reporting, BigQuery SQL, funnel and acquisition analysis, an interactive dashboard, business recommendations, and a GitHub case study.

## Current status

### Completed or prepared

- Mapped the original business questions to GA4 metrics, dimensions, and analysis methods.
- Documented the GA4 events, dimensions, metrics, key-event configuration, and interpretation rules.
- Reviewed user-supplied GA4 reports for acquisition, engagement, device, country, products, and funnel performance.
- Wrote evidence-based findings, limitations, and recommendations.
- Created and published a self-contained interactive dashboard from the supplied GA4 screenshot values. It is hosted on GitHub Pages at https://mahima68.github.io/Google-Merchandise-Store-Analytics/dashboard/; its figures are static and do not update from GA4 or BigQuery.
- Executed five BigQuery query areas against Google's public obfuscated sample (inventory, first-user acquisition, device/geography, item performance, and an ordered session funnel); captured outputs and limits are documented separately.
- Published and verified the case study files in `mahima68/Google-Merchandise-Store-Analytics`.

### Still to do

- Reconcile GA4 funnel settings/date ranges and validate ecommerce event instrumentation; this needs access to the intended GA4 property's explorations and event payloads.
- The dashboards are static snapshots. Refresh them when new, consistently dated GA4 report outputs are available; the latest public-sample query results are now reflected in the separate sample dashboard.

## Data access: how to finish without owning the demo property's project

The Google Merchandise Store demo property is owned by Google. Access to its GA4 reports does not give the analyst ownership or IAM access to the Cloud project linked in GA4 Admin (`adh-demo-data-review`, displayed as “Demoverse”). Do not try to grant yourself permissions on that project; only a Cloud project owner or IAM administrator can do so.

Use Google's **public obfuscated GA4 ecommerce sample** for the SQL portfolio work instead. It is a different dataset from the demo property reports and covers **November 1, 2020 through January 31, 2021**. Google explicitly cautions that it cannot be compared to the Analytics demo account. [Google's sample-dataset guide](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset)

### BigQuery Sandbox route

1. A Google Cloud project, **GMS Analytics** (`gms-analytics-510721`), has now been created under the signed-in account.
2. BigQuery Studio opens in **Sandbox** mode. The paid trial was not started and billing was not enabled.
3. The inventory query's displayed estimate was **179.02 MB** and returned **4,295,584 event rows**, **270,154 distinct pseudonymous users**, and **17 event names**.
4. Acquisition, product, ordered session-funnel, and device/geography queries were also run. Their captured results and estimates are recorded in [`../outputs/bigquery-public-sample-results.md`](../outputs/bigquery-public-sample-results.md).
5. All five planned BigQuery query areas have now been executed. Keep all public-sample output separate from the GA4 screenshot findings labeled 2026.

Google says the public sample can be explored with BigQuery Sandbox or the free usage tier, subject to limits, and its data is obfuscated. [Dataset guide](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset) · [BigQuery public dataset location notes](https://docs.cloud.google.com/bigquery/docs/datasets-intro)

The first-user acquisition query (223 MB displayed estimate) was re-run successfully. Its latest leading source/medium purchase-revenue results are documented in [`../outputs/bigquery-public-sample-results.md`](../outputs/bigquery-public-sample-results.md); the previous note saying those values were unavailable is superseded.

### BigQuery execution status

The Cloud project is **GMS Analytics** (`gms-analytics-510721`), and BigQuery Sandbox is active. The paid trial was not started and billing was not enabled. Five query areas completed; verified scan estimates and the captured inventory, funnel, acquisition, product, and device/geography observations are in [`../outputs/bigquery-public-sample-results.md`](../outputs/bigquery-public-sample-results.md). Do not start a paid trial merely to run the public sample.

### If you need the actual demo property's own raw export

Only the owner/administrator of `adh-demo-data-review` can grant access. The required access for query work is generally BigQuery Job User on the job project and BigQuery Data Viewer on the export dataset. [Google's query-role requirements](https://docs.cloud.google.com/bigquery/docs/running-queries). Because you are working individually and do not own that project, the public sample is the practical route for the SQL portion. To export future data from a property you control, link that property to your own Cloud project; this does not retroactively give you the demo property's raw history. [GA4 BigQuery export setup](https://support.google.com/analytics/answer/9823238)

## Source and comparison rules

The report values below were transcribed from screenshots the analyst supplied in chat. They are not a single joined export. Date ranges were visible on some, but not all, screenshots. For example, acquisition and product reports were verified as **September 7–October 4, 2026**, whereas a latest saved funnel exploration used **September 8–October 5, 2026**, and multiple funnel explorations had different settings. Country/device reports also have different metric scopes. Treat each table below as its own extract.

Two revenue measures appear: **Total revenue** in acquisition/demographics and **Item revenue** in product reporting. They have different definitions and should not be added together. `Items purchased` is units, not order count. `(not set)` and blank values are missing classifications, not business segments.

## Findings from GA4 screenshots

### 1. Acquisition and channel performance — latest Traffic acquisition screenshot

**Report total:** 129,908 sessions; 54,136 engaged sessions; 41.67% engagement rate; 55 seconds average online session engagement; 14.58 online session events per session; 1,893,432 events; 153,316 key events; 23.34% session key-event rate; **$320,420.82 total revenue**.

| Session default channel group | Sessions | Engaged sessions | Engagement rate | Avg session engagement | Events/session | Key events | Session key-event rate | Total revenue |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Organic Video | 64 | 50 | 78.13% | 1m 54s | 24.47 | 213 | 59.38% | $232.09 |
| Referral | 2,251 | 1,582 | 70.28% | 1m 52s | 26.08 | 6,218 | 36.78% | $14,792.64 |
| Organic Social | 699 | 533 | 76.25% | 1m 51s | 27.80 | 2,052 | 44.35% | $11,206.59 |
| Organic Search | 33,740 | 24,066 | 71.33% | 1m 17s | 18.75 | 53,266 | 39.58% | $99,795.72 |
| Organic Shopping | 632 | 538 | 85.13% | 1m 10s | 16.16 | 1,272 | 78.01% | $916.80 |
| Cross-network | 1,138 | 764 | 67.14% | 1m 02s | 16.98 | 1,408 | 30.67% | $2,016.16 |
| Unassigned | 6,867 | 895 | 13.03% | 56s | 23.45 | 5,750 | 23.62% | $3,498.93 |
| Direct | 80,809 | 23,956 | 29.65% | 44s | 11.69 | 80,460 | 15.90% | $180,633.62 |
| Email | 53 | 50 | 94.34% | 43s | 11.96 | 18 | 11.32% | $0.00 |
| Paid Search | 6,254 | 2,127 | 34.01% | 20s | 7.25 | 2,659 | 12.01% | $7,328.27 |

Direct and Organic Search together contribute 88.17% of sessions and 87.50% of the report's total revenue. Referral has $6.57 revenue/session (14,792.64 ÷ 2,251) and 70.28% engagement across 2,251 sessions. Organic Social has $16.03/session but only 699 sessions; its rate is volatile. Paid Search has 20 seconds average session engagement and $1.17/session across 6,254 sessions; investigate channel/source, campaigns, and landing pages before changing spend.

**Separate initial channel extract with Purchasers and Active Users:** This was supplied earlier and has a different total/session scope. The table's purchase rate equals Purchasers ÷ Active Users; do not merge it with the later Traffic acquisition screenshot.

| Channel | Purchasers | Active users | Sessions | Engaged sessions | Engagement rate | Avg engagement | Key events | Key event rate | Revenue | Revenue/session | Purchasers ÷ active users |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Direct | 1,088 | 64,197 | 79,105 | 23,745 | 30.02% | 45s | 80,224 | 16.11% | $180,566.59 | $2.28 | 1.69% |
| Organic Search | 429 | 21,843 | 33,150 | 23,734 | 71.60% | 1m 17s | 52,555 | 39.58% | $98,864.33 | $2.98 | 1.96% |
| Unassigned | 31 | 6,427 | 6,679 | 868 | 13.00% | 56s | 5,598 | 23.79% | $3,498.93 | $0.52 | 0.48% |
| Paid Search | 26 | 5,074 | 6,225 | 2,116 | 33.99% | 20s | 2,632 | 11.94% | $7,311.00 | $1.17 | 0.51% |
| Referral | 80 | 1,278 | 2,230 | 1,568 | 70.31% | 1m 51s | 6,171 | 36.86% | $14,792.64 | $6.63 | 6.26% |
| Cross-network | 14 | 1,035 | 1,078 | 724 | 67.16% | 1m 13s | 1,522 | 31.17% | $2,848.63 | $2.64 | 1.35% |
| Organic Shopping | 20 | 507 | 621 | 531 | 85.51% | 1m 11s | 1,263 | 78.42% | $916.80 | $1.48 | 3.94% |
| Organic Social | 21 | 395 | 695 | 530 | 76.26% | 1m 51s | 2,050 | 44.46% | $11,206.59 | $16.12 | 5.32% |
| Organic Video | 2 | 40 | 62 | 49 | 79.03% | 1m 53s | 207 | 59.68% | $232.09 | $3.74 | 5.00% |
| Email | 0 | 9 | 53 | 50 | 94.34% | 43s | 18 | 11.32% | $0.00 | $0.00 | 0.00% |

The initial extract points to Referral having the highest purchaser/active-user ratio among channels with meaningful volume (6.26%); Organic Social is also high at 5.32% on only 395 active users. Those are **user-based rates**. The later session key-event rate is different and not a purchase rate: GA4 Admin showed `add_to_cart`, `purchase`, `view_item`, and `xyz` all marked as key events.

### 2. Engagement overview

- Average online active-user engagement time: **1m 13s**.
- Engaged online sessions per active user: **0.55**.
- Average online session engagement: **55s**.
- Active users: **104k in 30 days**, **31k in 7 days**, **2.7k in 1 day** (overview screenshot).
- User stickiness: **DAU/MAU 2.6%**, **DAU/WAU 8.7%**, **WAU/MAU 29.9%**.
- Event counts shown: `view_item_list` 522k; `page_view` 508k; `view_item` 128k; `session_start` 126k; `select_item` 94k; `first_visit` 88k; `view_promotion` 73k.
- Most viewed page titles: Home 121k views; Google Merch Shop 39k; Men's / Unisex 25k; New 21k; Sale 18k; Apparel 13k; 1998 Retro Collection 13k.

### 3. Devices

- Platform: **Web 100%** of active users.
- Device category: **Mobile 63.6%**, **Desktop 35.7%**, **Tablet 0.7%**. Desktop active users were shown as **35,325**.
- Operating systems: Android 53k; Macintosh 18k; Windows 12k; iOS 10k; Chrome OS 4.3k; Linux 992; UNIX 6.
- Browser chart showed Chrome, Safari, Edge, Safari (in-app), Firefox, Samsung Internet, and Android WebView; exact row values were not supplied.

### 4. Countries — Demographic details report

**Report total:** 98,681 active users; 88,062 new users; 54,136 engaged sessions; 41.67% engagement rate; 1,893,432 events; 153,316 key events; 22.71% user key-event rate; **$320,420.82 revenue**.

| Country | Active users | New users | Engaged sessions | Engagement rate | Avg engaged sessions/user | Avg engagement time | Key events | User key-event rate | Revenue |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| (not set) | 40,325 | 40,276 | 41 | 0.10% | <0.01 | 0s | 84 | 0.05% | $0.00 |
| United States | 29,553 | 22,540 | 33,871 | 66.70% | 1.15 | 2m 54s | 118,896 | 48.24% | $293,769.81 |
| India | 5,360 | 4,604 | 4,266 | 59.42% | 0.80 | 1m 08s | 4,683 | 27.41% | $820.58 |
| Japan | 3,511 | 3,320 | 972 | 23.19% | 0.28 | 33s | 2,041 | 12.02% | $189.77 |
| Canada | 1,758 | 1,341 | 1,705 | 60.57% | 0.97 | 1m 52s | 4,015 | 41.70% | $9,710.18 |
| (blank country) | 1,492 | 1,492 | 6 | 0.40% | <0.01 | 0s | 6 | 0.40% | $0.00 |
| Taiwan | 1,288 | 1,072 | 1,428 | 63.52% | 1.11 | 2m 39s | 3,620 | 47.52% | $1,249.56 |
| Singapore | 974 | 920 | 781 | 56.68% | 0.80 | 1m 37s | 1,773 | 33.06% | $1,107.41 |
| United Kingdom | 973 | 854 | 817 | 63.38% | 0.84 | 1m 09s | 1,490 | 39.77% | $2,355.77 |
| Germany | 924 | 823 | 794 | 61.98% | 0.86 | 1m 13s | 1,126 | 33.87% | $528.55 |

United States contributes **91.68% of reported revenue** on **29.95% of active users**. `(not set)` is 40.86% of active users, so geography needs a data-quality caveat. The automated GA4 anomaly card reported a US active-user surge on September 28, 2026 (about 6.9k vs expected 1.2k) and associated Chrome/homepage/Direct increases; verify underlying data before repeating its explanation as a finding.

### 5. Products — E-commerce purchases report

**Report total:** 127,152 items viewed; 76,647 items added to cart; **21,303 items purchased**; **$298,474.21 item revenue**.

**Top products by items purchased (unit count):**

| Rank | Item | Items viewed | Added to cart | Items purchased | Item revenue |
|---:|---|---:|---:|---:|---:|
| 1 | Chrome Dino Gradient Sparkle Sticker | 502 | 1,674 | 995 | $1,800.00 |
| 2 | Google Sticker | 470 | 2,239 | 936 | $1,156.50 |
| 3 | Google Pen White | 325 | 2,272 | 828 | $1,383.60 |
| 4 | Google Black Wheat Pen | 254 | 1,031 | 451 | $724.80 |
| 5 | Google Recycled Gray Notebook | 146 | 762 | 443 | $3,552.00 |
| 6 | Google Camp Mug White | 606 | 857 | 397 | $5,507.20 |
| 7 | Google Pen Bright Blue | 76 | 986 | 355 | $614.80 |
| 8 | Google Bamboo Lid Recycled Bottle | 277 | 911 | 321 | $2,635.20 |
| 9 | Android Googler Figurine | 1,565 | 1,256 | 301 | $5,937.60 |
| 10 | Google Eco Tee Black | 1,560 | 724 | 288 | $6,518.40 |

**Top products by item revenue:**

| Rank | Item | Items viewed | Added to cart | Items purchased | Item revenue |
|---:|---|---:|---:|---:|---:|
| 1 | Google Marine Layer 1998 Pullover | 6,583 | 2,199 | 189 | $19,350.00 |
| 2 | Google Timbuk2 Tuck Backpack | 2,069 | 612 | 86 | $8,605.60 |
| 3 | Google Wellfleet 1/2 Zip | 2,331 | 332 | 110 | $6,983.60 |
| 4 | Google Nantucket Sweatshirt | 1,216 | 321 | 125 | $6,982.80 |
| 5 | Google Stripe Picnic Blanket | 264 | 418 | 169 | $6,770.00 |
| 6 | Google Eco Tee Black | 1,560 | 724 | 288 | $6,518.40 |
| 7 | Android Googler Figurine | 1,565 | 1,256 | 301 | $5,937.60 |
| 8 | Google Camp Mug White | 606 | 857 | 397 | $5,507.20 |
| 9 | Google Heritage Suede Cap | 777 | 736 | 265 | $5,107.20 |
| 10 | Google Brant Point Pullover | 1,577 | 222 | 68 | $4,360.80 |

**High views / low purchase review candidates:** Marine Layer Pullover (6,583 views; 189 units, 2.87% units/view) and Recycled Black Hoodie (2,459 views; 14 units, 0.57%; 83 cart additions). These are item-quantity ratios, not unique-shopper conversion rates. Check availability, variants, price/shipping clarity, and event capture before deciding why the ratio is low.

### 6. Funnel explorations — keep each screenshot configuration separate

The shared funnel steps were `view_item` → `add_to_cart` → `begin_checkout` → `purchase`. The most recently supplied channel funnel showed:

| Step | Active users | Completion to next step | Abandonments | Abandonment rate |
|---|---:|---:|---:|---:|
| view_item | 83,710 | 99.52% | 400 | 0.48% |
| add_to_cart | 83,310 | 99.93% | 58 | 0.07% |
| begin_checkout | 83,252 | 1.15% | 82,293 | 98.85% |
| purchase | 959 | — | — | — |

The report shows almost all users progressing from `view_item` to `add_to_cart` and from `add_to_cart` to `begin_checkout`, then a 98.85% drop between `begin_checkout` and `purchase`. Some channel rows' counts do not agree with their displayed abandonment values. Validate funnel step definitions, filters, and screenshot period before finalizing this funnel.

**By device (a different funnel screenshot):**

| Device | view_item users | add_to_cart users | begin_checkout users | Purchasers | Checkout-start → purchase completion |
|---|---:|---:|---:|---:|---:|
| Mobile | 61,340 | 61,340 | 61,327 | 101 | 0.16% |
| Desktop | 24,944 | 24,944 | 24,930 | 856 | 3.43% |
| Tablet | 617 | 617 | 616 | 5 | 0.81% |
| Total | 86,056 | 86,056 | 86,032 | 962 | 1.12% |

The device rows are copied as displayed. Their Step 1 counts sum to 86,901, whereas the screenshot's total row says 86,056; step 2 and step 3 have the same mismatch. This needs to be resolved from the GA4 exploration before treating the device-level totals as reconciled.

**By channel (channel funnel screenshot):**

| Channel | view_item | add_to_cart | begin_checkout | purchase | Checkout-start → purchase completion |
|---|---:|---:|---:|---:|---:|
| Direct | 58,508 | 58,080 | 58,040 | 697 | 1.20% |
| Organic Search | 18,413 | 18,366 | 18,342 | 188 | 1.02% |
| Paid Search | 4,586 | 4,580 | 4,579 | 7 | 0.15% |
| Unassigned | 1,112 | 1,107 | 1,107 | 2 | 0.18% |
| Referral | 819 | 816 | 815 | 26 | 3.19% |
| Total | 83,710 | 83,310 | 83,252 | 959 | 1.15% |

**By country (same 83,710-user screenshot):**

| Country | view_item | add_to_cart | begin_checkout | purchase | Checkout-start → purchase completion |
|---|---:|---:|---:|---:|---:|
| (not set) | 40,423 | 40,423 | 40,423 | 0 | 0.00% |
| United States | 21,667 | 21,645 | 21,627 | 897 | 4.15% |
| India | 4,447 | 4,412 | 4,400 | 3 | 0.07% |
| Japan | 3,238 | 3,237 | 3,236 | 2 | 0.06% |
| Canada | 1,275 | 1,273 | 1,272 | 21 | 1.65% |

The very low displayed mobile rate compared with desktop merits a mobile checkout and purchase-event QA review. It does **not** prove the site is broken. The `begin_checkout` to `purchase` step is the largest apparent loss; confirm the funnel uses the intended event-scoped users, ordered steps, and date range.

## Business questions answered by the supplied GA4 screenshots

| Question | Status | Evidence/limit |
|---|---|---|
| Where do users come from? | Partly answered | Default channel group is available. Source/medium and campaign detail were not supplied. |
| Which channels generate most traffic/revenue? | Answered for supplied channel extract | Direct and Organic Search lead both sessions and total revenue. |
| Which channel has the highest purchase conversion? | Partly answered | Earlier Purchasers ÷ Active Users rates supplied; different from Session key event rate and other session funnel rates. |
| How engaged are users? | Answered at overview/channel level | 1m13s active-user engagement overall; per-channel engagement table supplied. |
| Which devices do users use? | Answered | Mobile 63.6%, Desktop 35.7%, Tablet 0.7%. |
| Which countries generate the most users? | Answered, with missing-data issue | US leads among named countries; `(not set)` is 40.86% of active users. |
| Which products are purchased most and generate most revenue? | Answered | Top unit and item-revenue lists supplied. |
| Which products have high views but low purchases? | Partly answered | Marine Layer Pullover and Recycled Black Hoodie are screening candidates; ratio is item-level. |
| How many users progress through funnel / where do they drop? | Partly answered | Funnel counts and breakdowns supplied, but date/configuration/instrumentation require validation. |
| Do funnel outcomes differ by channel/device/country? | Partly answered | Breakdown screens supplied; some denominators are small and/or missing classifications. |

## Recommendations to investigate

1. Validate the funnel definition and event tracking; specifically inspect `begin_checkout` and `purchase`, transaction ID, value, currency, items, and event sequence.
2. Compare mobile checkout usability, page performance, payment options, and purchase event capture against desktop.
3. Review the Marine Layer Pullover and Recycled Black Hoodie product detail pages, variants/inventory, price, shipping/returns, and cart instrumentation.
4. Check Paid Search campaign/source/medium and landing pages; use spend and margin before making budget decisions.
5. Investigate why 40.86% of demographic users show country `(not set)`.
6. Re-export acquisition, product, and funnel reports using a consistent date range before presenting a single final KPI story.

## Files created for the project

- `README.md` — project overview, source separation, run instructions, and truthful status.
- `docs/data-dictionary-and-scope.md` — data dictionary, event/metric definitions, caveats.
- `docs/business-questions.md` — questions-to-measurement plan and progress.
- `analysis/findings.md` — concise executive findings and recommendations.
- `dashboard/index.html` — published interactive static dashboard based on supplied GA4 figures.
- `sql/01_data_inventory.sql` through `sql/05_session_funnel.sql` — SQL used for the five executed query areas; recorded outputs and scan estimates are in the output report.

The SQL source is Google's public table `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`. Google's GA4 export schema uses one `analytics_<property_id>` dataset per linked property and daily `events_YYYYMMDD` tables when daily export is enabled. [Export schema reference](https://support.google.com/analytics/answer/7029846)
