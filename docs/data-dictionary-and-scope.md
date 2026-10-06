# Phase 1: Data Dictionary and Project Scope

## Project

**Google Merchandise Store — End-to-End E-commerce Analytics**

This project analyzes Google Analytics 4 (GA4) reports for the Google Merchandise Store and separately queries Google's public obfuscated ecommerce sample in BigQuery. The sample is a different dataset and period; it does not reproduce the supplied GA4 interface findings. The actual demo property's BigQuery export is not accessible to the analyst.

## Analysis scope

### In scope

- Acquisition by default channel group; source/medium and campaign when available.
- User engagement and activity by channel, device, and country.
- Ecommerce item views, cart additions, item purchases, and item revenue.
- A user funnel from `view_item` through `add_to_cart`, `begin_checkout`, and `purchase`.
- Funnel comparisons by device, channel, and country.
- Data quality checks for missing classifications and event tracking.

### Out of scope for the current first pass

- Causal claims about why a channel or product performs as it does.
- Profit, margin, advertising spend, or return on ad spend; these fields have not been provided.
- Customer lifetime value or repeat-purchase cohorts.
- A validated diagnosis of checkout issues. The observed funnel drop is a signal to investigate, not proof of a site defect.

## Data source and period

| Item | Current understanding | Verification needed |
|---|---|---|
| Analytics platform | Google Analytics 4 property labeled “GA4 - Google Merch Shop” | Confirm property/account details and access owner if publishing externally. |
| Collection | GA4 reports for a web storefront | Confirm ecommerce implementation and event parameters. |
| Report date range | Traffic acquisition report verified as **September 7–October 4, 2026**. The latest saved funnel exploration inspected in GA4 was set to **Last 28 days: September 8–October 5, 2026**. | The funnel screenshots previously shared may come from another saved funnel version; align dates and settings before comparing funnel results to reports. |
| BigQuery link | GA4 Admin shows a completed link to project ID `adh-demo-data-review`, project name `Demoverse`; project location is United States (`us`). | The project is not owned by the analyst and is not available in the current Cloud account's project picker. The public obfuscated sample will be used for SQL practice; the linked dataset name, event tables, and schema remain unverified. |
| BigQuery event export configuration | Link detail shows 1 of 1 stream selected, no events excluded, and Daily plus Streaming (best-effort) selected for event data. GA4 could not retrieve Cloud project billing status; the UI warns streaming may not export at that frequency unless billing is enabled. | Confirm export tables and freshness in BigQuery after the terms step. User data export Daily is not selected. |
| Currency | Revenue is displayed in USD | Confirm the property's reporting currency and whether all underlying transactions use USD. |
| Data completeness | GA4 screens displayed “100% of available data” | This indicates the report used its available data; it does not validate event instrumentation or remove `(not set)` values. |

## Verified key-event configuration

GA4 Admin → Events → Key events showed these four events marked as key events:

| Event | Status in property | Note |
|---|---|---|
| `add_to_cart` | Key event | Ecommerce action, not a completed purchase. |
| `purchase` | Key event | Purchase event. |
| `view_item` | Key event | Product view, not a completed purchase. |
| `xyz` | Key event | GA4 showed no stream data detected for this event. Its purpose is unknown. |

Therefore, the Traffic acquisition report's **Session key event rate (All events)** combines sessions with any of these key events. It is **not a purchase conversion rate**. Use a purchase-specific metric or a clearly defined funnel when analyzing purchase conversion. Do not change the property configuration as part of this analysis without an explicit measurement decision.

## Event dictionary

Events below were visible in the supplied GA4 reports or configured funnel. Their presence in a report does not by itself validate that they fire once, with correct parameters, for every intended user action.

| Event name | Business meaning in this analysis | Where used | Validation still needed |
|---|---|---|---|
| `page_view` | A page was viewed | Engagement overview | Check page-view implementation and duplicate behavior. |
| `session_start` | A session began | Engagement overview | Check session reporting conventions. |
| `first_visit` | GA4 recorded a first visit for a browser/device identifier | Engagement overview | Not equivalent to a verified new human customer. |
| `view_item_list` | An item list was shown | Engagement overview | Validate list/item parameters if analyzing products. |
| `select_item` | An item was selected from a list | Engagement overview | Validate item identifiers and list context. |
| `view_item` | An item detail was viewed; funnel step 1 | Ecommerce report and funnel | Confirm item data is sent in the event. |
| `add_to_cart` | Item(s) were added to cart; funnel step 2 | Ecommerce report and funnel | Validate event and item quantity/identity. |
| `begin_checkout` | Checkout began; funnel step 3 | Funnel | Validate what user action triggers this event and whether it is duplicated. |
| `purchase` | A purchase was recorded; funnel step 4 | Ecommerce report and funnel | Validate transaction ID, item data, value, currency, and deduplication. |
| `view_promotion` | A promotion was viewed | Engagement overview | Not in current core analysis; validate promotion parameters if used. |

## Dimension dictionary

| Dimension | Definition/use in this project | GA4 report field observed |
|---|---|---|
| Default channel group | Rule-based grouping of session acquisition traffic, such as Direct, Organic Search, Referral, and Paid Search | Session primary channel group (Default Channel Group) / Session default channel group |
| Session source / medium | More specific session origin and traffic type, such as a referring site or search engine/organic | Planned; not yet supplied in a report |
| Session campaign | Campaign associated with a session | Planned; not yet supplied in a report |
| Device category | Device class used, such as mobile, desktop, or tablet | Device category / Platform-device category |
| Operating system | Operating system associated with the user's device | Operating system |
| Country | Country attributed to the user/session in the report | Country; includes `(not set)` |
| Item name | Product name associated with ecommerce item events | Item name |
| Page title and screen class | Page/screen label for content engagement | Page title and screen class |
| Event name | Name of the recorded interaction | Event name |

## Metric dictionary

Metric definitions and scopes must be kept explicit because similarly named GA4 metrics can count different things.

| Metric | Working definition/use | Scope or caution |
|---|---|---|
| Active users | GA4 users considered active in the selected date range | User metric; not the same as sessions or event count. |
| Sessions | Sessions started in the selected date range | Session metric. |
| Engaged sessions | Sessions that meet GA4's engaged-session criteria | Session metric; confirm current GA4 definition when documenting methodology. |
| Engagement rate | Engaged sessions divided by sessions | Session-level ratio. |
| Average engagement time | Average time the site/app was in focus/foreground, according to GA4 reporting | The exact displayed variant is recorded per report (active-user or session average). |
| Purchasers | Users GA4 identifies as having made a purchase, where available | User-level metric; distinct from orders, purchase events, or units. |
| Purchase rate (channel table) | Purchasers ÷ Active Users, as specified for the supplied channel table | User-based rate. Do not substitute Session key event rate. |
| Session key event rate | Sessions with a key event divided by sessions, per GA4 | Not necessarily purchase conversion unless purchase is the only relevant key event/configuration. |
| Key events / Key event rate | Configured GA4 key-event counts/rates | Depends on property key-event configuration; not automatically equivalent to purchases. |
| Items viewed | Number of item views represented by item data in `view_item` events | Item-level activity, not unique users. |
| Items added to cart | Number of items represented in `add_to_cart` events | Item-level quantity metric, not necessarily number of users or cart events. |
| Items purchased | Quantity of items represented in purchase events | Units, not order count. |
| Item revenue | Item-level revenue; GA4 defines this from item price and quantity and excludes tax and shipping | Distinct from total revenue. |
| Funnel completion rate | The rate shown by GA4 Funnel exploration for progression between configured steps | Record the exact step pair and funnel settings; do not assume it is the same as the channel table's purchase rate. |
| Funnel abandonment | Users who reached a funnel step but did not complete the next configured step, as calculated by the exploration | Depends on open/closed funnel, direct/indirect step rules, time window, and breakdown attribution. |
| Item purchase-to-view ratio | Items purchased ÷ items viewed | A descriptive item-level ratio, not a user conversion rate. |

## Measurement and comparison rules

1. Record the date range, report name, dimension, and metric definitions for every exported result.
2. Align date ranges before comparing channels, countries, devices, products, or funnel results.
3. Keep user, session, event, and item scopes separate. Do not compare ratios with different denominators as if they were the same conversion measure.
4. Treat `(not set)` as missing/unavailable classification, not as a real country or channel.
5. Treat low-volume channel rates as directional and show their session/user volume beside the rate.
6. The funnel's large `begin_checkout` to `purchase` drop requires an instrumentation and funnel-definition check before recommending a checkout change.
7. GA4 anomaly cards are exploratory prompts; validate their underlying report data before using them as findings.

## Open items before Phase 1 is fully verified

- Align the date range on each report and funnel exploration; multiple saved funnel explorations exist with different step configurations.
- Investigate the purpose of the custom `xyz` key event and why it has no stream data detected.
- Inspect ecommerce event parameters and transaction deduplication in the property.
- The public sample's five query areas have been run in BigQuery Sandbox. The linked `adh-demo-data-review` export remains inaccessible unless its owner grants access.
- Export or capture the reports with date range and dimension visible so the results can be reproduced.

## Official references

- [GA4 BigQuery export schema](https://developers.google.com/analytics/bigquery/schemas)
- [GA4 ecommerce purchases report](https://support.google.com/analytics/answer/12924131?hl=en)
- [GA4 ecommerce metrics](https://support.google.com/analytics/answer/13428834?hl=en)
- [GA4 Funnel exploration](https://support.google.com/analytics/answer/9327974?hl=en)
