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
| Traffic acquisition | | | | | No |
| Engagement overview | | | | | No |
| Tech overview/details | | | | | No |
| Demographic details: Country | | | | | No |
| Ecommerce purchases: Item name | | | | | No |
| Funnel: Device category | | | | | No |
| Funnel: Session default channel group | | | | | No |
| Funnel: Country | | | | | No |

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

**Verification status.** The acquisition date range (September 7–October 4, 2026) and saved funnel exploration ranges/settings were inspected in GA4, but screenshots and explorations do not share one confirmed date range. Key-event configuration was verified: `add_to_cart`, `purchase`, `view_item`, and `xyz` are marked as key events; `xyz` showed no stream data detected. The GA4 BigQuery Link was verified to project `adh-demo-data-review` (`Demoverse`), with one stream selected, no exclusions, and Daily plus Streaming (best-effort) export selected. The actual export dataset/tables/schema, purchase event parameters, and event implementation remain unverified.
