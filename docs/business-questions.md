# Phase 2: Business Questions and Measurement Plan

This document turns the project brief into measurable questions. GA4 interface findings and separate SQL analysis of Google's public obfuscated sample are documented. They use different datasets and dates and must not be combined as one extract.

## Acquisition

| Business question | Metrics | Dimensions/breakdowns | GA4 method | SQL plan |
|---|---|---|---|---|
| Where do users come from? | Sessions, active users | Session default channel group; session source / medium; session campaign | Reports → Acquisition → Traffic acquisition. Start with channel group, then change the table dimension to source / medium and campaign. | Build session-level source/medium and campaign fields; count distinct sessions and users. |
| Which acquisition channels generate the most traffic? | Sessions, active users | Session default channel group | Traffic acquisition; sort by Sessions. | Aggregate sessions and distinct users by session channel group. |
| Which channels generate the most revenue? | Total revenue; optionally item revenue | Session default channel group | Traffic acquisition; compare Total revenue by channel. | Aggregate revenue by session attribution fields; document attribution scope. |
| Which channels have the highest conversion rates? | Purchasers ÷ active users for user purchase rate; or sessions with purchase ÷ sessions for session rate | Session default channel group | Traffic acquisition plus a clearly defined purchase metric; do not substitute Session key event rate unless its key-event configuration is confirmed. | Calculate an explicitly named numerator/denominator pair and show volume beside rate. |

## User behavior

| Business question | Metrics | Dimensions/breakdowns | GA4 method | SQL plan |
|---|---|---|---|---|
| How engaged are users? | Engaged sessions, engagement rate, average engagement time, engaged sessions per active user | Overall; optionally channel, device, country | Reports → Engagement → Overview; Traffic acquisition for channel comparison. | Reproduce session engagement metrics with the relevant event/session fields and validate against GA4 definitions. |
| Which devices do users use? | Active users, sessions | Device category; optionally operating system and browser | Reports → User → Tech → Tech details. | Aggregate users/sessions by `device.category`, operating system, and browser. |
| Which countries generate the most users? | Active users; optionally sessions, revenue | Country | Reports → User → User attributes → Demographic details. | Aggregate by `geo.country`; report `(not set)` separately. |
| Where do users drop out of the shopping journey? | Users at each step, step conversion, abandonment, elapsed time | Ordered events: `view_item`, `add_to_cart`, `begin_checkout`, `purchase` | Explore → Funnel exploration; optionally Explore → Path exploration for next actions. | Build ordered event sequences at a declared user/session scope; compute step reach and drop-off. |

## E-commerce and products

| Business question | Metrics | Dimensions/breakdowns | GA4 method | SQL plan |
|---|---|---|---|---|
| Which products are purchased most frequently? | Items purchased; optionally purchasers | Item name or item ID | Reports → Monetization → Ecommerce purchases; sort by Items purchased. | `UNNEST(items)` on purchase events; sum item quantity by item. |
| Which products generate the most revenue? | Item revenue | Item name or item ID | Ecommerce purchases; sort by Item revenue. | Sum item price × quantity for purchase items; account for refunds if in scope. |
| Which products have high views but low purchases? | Items viewed, items purchased, item purchase-to-view ratio | Item name or item ID | Ecommerce purchases; sort by Items viewed and compare Items purchased. | Aggregate item views and purchase quantities by item; calculate the descriptive ratio and label it as item-level, not user conversion. |

## Funnel segmentation

| Business question | Metrics | Dimensions/breakdowns | GA4 method | SQL plan |
|---|---|---|---|---|
| How many users progress from product viewing to purchase? | Users reaching each funnel step | Funnel step | Funnel exploration with `view_item` → `add_to_cart` → `begin_checkout` → `purchase` | Count distinct users or sessions at each ordered step; explicitly select and document scope. |
| At which stage do users drop off? | Step completion, abandonment count/rate, elapsed time | Funnel step | Funnel exploration; inspect abandonment between consecutive steps and optionally elapsed time. | Calculate step-to-step losses from the ordered funnel output. |
| Does funnel performance differ by channel, device, or country? | Users at each step, step conversion, abandonment | Session default channel group, device category, country | Duplicate the same Funnel exploration and set one breakdown at a time. | Join session/user dimensions to funnel entrants and calculate the same funnel metrics by segment. |

## Definitions to lock before comparing results

- **User purchase rate:** purchasers ÷ active users. This is the definition supplied for the initial channel table.
- **Session purchase rate:** sessions containing a purchase ÷ sessions. Use only when that is the intended denominator.
- **Session key event rate:** a GA4 metric whose meaning depends on the property's key-event configuration; it is not automatically purchase conversion.
- **Item purchase-to-view ratio:** items purchased ÷ items viewed. This compares item quantities and is not a user conversion rate.
- **Funnel conversion:** must name the specific step pair, funnel type (open/closed), direct/indirect step rule, time window, and whether the count is users or sessions.

## Completion status

- Business questions and required measurements: documented.
- Initial GA4 explorations: supplied for acquisition channel groups, engagement, device, country, product performance, and funnel breakdowns.
- Traffic acquisition date range: verified as **September 7–October 4, 2026**. The latest saved funnel exploration inspected in GA4 was **September 8–October 5, 2026**; other saved Funnel explorations have different configurations, so the screenshots are not yet confirmed to use aligned periods/settings.
- Key-event configuration: verified in GA4 Admin. `add_to_cart`, `purchase`, `view_item`, and `xyz` are marked as key events; `xyz` showed no stream data detected. Therefore, Session key event rate is not purchase-only.
- GA4 event implementation and ecommerce parameters: **not verified**.
- BigQuery link: verified to project `adh-demo-data-review` (`Demoverse`); one stream is selected, no events excluded, Daily and Streaming (best-effort) are selected for event data. Actual BigQuery dataset/tables and schema are **not verified**. GA4 could not retrieve Cloud billing status and warns streaming frequency may depend on billing.
- BigQuery: The GA4 demo property's linked Cloud project is not owned by the analyst and is not visible in the current project picker. SQL is authored against Google's separate public obfuscated ecommerce sample; the GA4 demo export itself remains inaccessible and must not be represented as queried.
- BigQuery query areas for inventory, first-user acquisition, device/geography, products, and ordered session funnel: **executed against the public sample** `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` (2020-11-01 through 2021-01-31), not the 2026 GA4 screenshots. Captured results and limitations are in `outputs/bigquery-public-sample-results.md`.
- Findings/recommendations report and self-contained local interactive dashboard: **prepared from the supplied GA4 screenshots**. The dashboard is not a live GA4 or BigQuery connection.
- GitHub publication: **published and verified** in `mahima68/Google-Merchandise-Store-Analytics`.

## Data collection checklist for the next GA4 review

For each report or exploration, record its date range and export the result with the report name, dimension, metric labels, and filters visible. Inspect whether the purchase event includes a transaction ID, currency, value, and item data. Then open the linked Google Cloud project and confirm the GA4 export dataset, table names, and recent data availability before beginning SQL work.
