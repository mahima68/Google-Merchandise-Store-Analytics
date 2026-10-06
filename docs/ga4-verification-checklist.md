# GA4 Verification Checklist

Use this checklist to close the Phase 1 verification items. Do not change GA4 settings during this review; inspect and record the current configuration.

## A. Confirm report date ranges

For each GA4 report or Exploration used in the analysis:

1. Open the report and note the date selector in the top-right corner.
2. Record the start date and end date, property time zone, report name, and any applied filters/comparisons.
3. Repeat separately for Acquisition, Engagement, Tech, Demographic details, Ecommerce purchases, and each Funnel exploration.
4. Only compare results directly when the date ranges and relevant filters match.

Record results here:

| GA4 report/exploration | Start date | End date | Time zone | Filters/breakdowns | Verified? |
|---|---|---|---|---|---|
| Traffic acquisition | 2026-09-07 | 2026-10-04 | Not captured | Session default channel group; no comparison shown | Yes (screenshot) |
| Engagement overview | Not captured | Not captured | Not captured | Overview cards and event/page lists | Partial |
| Tech overview/details | 2026-09-07 | 2026-10-04 | Not captured | Web platform; device category, OS, browser | Yes (screenshot) |
| Demographic details: Country | Not captured | Not captured | Not captured | Country breakdown | Partial |
| Ecommerce purchases: Item name | 2026-09-07 | 2026-10-04 | Not captured | Item name | Yes (screenshot) |
| Funnel: Device category | Not captured | Not captured | Not captured | User-based funnel; device category | Partial |
| Funnel: Session default channel group | 2026-09-08 | 2026-10-05 | Not captured | User-based funnel; session default channel group | Yes (saved exploration screenshot) |
| Funnel: Country | Not captured | Not captured | Not captured | User-based funnel; country | Partial |

## B. Check key-event configuration

1. In GA4, open **Admin → Data display → Events** (or the **Key events** view, depending on the current interface).
2. Record which events are marked as key events, especially whether `purchase` is marked and whether other funnel events are also key events.
3. Do not change the configuration as part of this analysis review.
4. In the write-up, call a GA4 **Session key event rate** a purchase conversion rate only if its configuration and numerator confirm that interpretation.

Google's current guidance: [Mark events as key events](https://support.google.com/analytics/answer/13128484?hl=en).

## C. Inspect purchase event data

Use **Reports → Engagement → Events** or **Explore** to confirm that `purchase` is being recorded. If property permissions allow, use DebugView or the site's test flow to inspect event parameters. Record whether purchase events include:

- `transaction_id` (used to identify/deduplicate transactions)
- `currency`
- `value`
- item data, including item ID/name, price, and quantity

Do not place a real order solely for this check. If a safe test transaction is not already available, mark event-parameter validation as pending.

## D. Check for a BigQuery export

1. In GA4, open **Admin → Product links → BigQuery Links**.
2. If a project link is listed, record the Google Cloud project ID, dataset location, export types (daily/streaming), linked data streams, and excluded events. Do not modify the link.
3. In BigQuery, locate the linked dataset and inspect table names. GA4 exports commonly use `events_YYYYMMDD` daily tables and may include an `events_intraday_YYYYMMDD` table; verify the actual project rather than assuming this naming is present.
4. Record the table schema and confirm access before beginning SQL work.
5. If no link exists, record “No export found.” Setting up a new export requires the appropriate GA4 and Google Cloud permissions and should be a separate deliberate setup step.

Google's setup and verification guidance: [Set up BigQuery Export](https://support.google.com/analytics/answer/9823238?hl=en) and [Compare GA4 reports with BigQuery exports](https://support.google.com/analytics/answer/13578783?hl=en).

## Current status

**Verification status.** The table above distinguishes report dates visible in screenshots from ranges/configurations that were not captured. The acquisition and item reports show September 7–October 4, 2026; the latest saved channel funnel exploration shows September 8–October 5, 2026. These are separate extracts and must not be merged as one period. Key-event configuration was verified: `add_to_cart`, `purchase`, `view_item`, and `xyz` are marked as key events; `xyz` showed no stream data detected. The GA4 BigQuery Link was verified to project `adh-demo-data-review` (`Demoverse`), with one stream selected, no exclusions, and Daily plus Streaming (best-effort) export selected. The actual export dataset/tables/schema, purchase event parameters, and event implementation remain unverified.
