# Google Merchandise Store E-commerce Analytics

An end-to-end portfolio case study using GA4 reporting for the Google Merchandise Store and reproducible BigQuery SQL patterns for Google's public GA4 ecommerce sample.

> **Data provenance matters:** The GA4 screenshots and the public BigQuery sample are different datasets and time periods. The screenshots cover reports around September–October 2026. Google's public sample is obfuscated data from November 1, 2020 to January 31, 2021. Findings from one source must not be presented as though they were calculated from the other.

## Business objective

Understand how shoppers arrive, engage, browse products, and purchase; identify funnel friction and product/channel opportunities; translate evidence into practical next steps.

## What is in this repository

- [`docs/business-questions.md`](docs/business-questions.md): question-to-metric map and what the screenshots answer.
- [`docs/data-dictionary-and-scope.md`](docs/data-dictionary-and-scope.md): metric definitions, caveats, event/dimension dictionary, and access notes.
- [`analysis/findings.md`](analysis/findings.md): evidence-based findings, recommendations, and limitations.
- [`dashboard/index.html`](dashboard/index.html): a self-contained, interactive dashboard of the supplied GA4 report values.
- [`dashboard/bigquery-sample.html`](dashboard/bigquery-sample.html): a separate report page for the executed 2020–2021 public-sample BigQuery results.
- [`sql/`](sql/): BigQuery Standard SQL templates for data inventory, acquisition, device/geography, ecommerce products, and session funnel analysis.

## Data sources

### GA4 interface findings (screenshots supplied for this case study)

The user's GA4 reports include channel acquisition, engagement, device, country, product, and funnel breakdowns. Report date ranges were not consistently visible across all screenshots; acquisition and product reports were previously verified as September 7–October 4, 2026, while saved funnel explorations used different settings/date windows. See the findings document for the exact scope and qualifications.

### BigQuery SQL source

The SQL uses Google's public table:

```text
bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*
```

It is the official obfuscated Google Merchandise Store ecommerce sample. It is **not** the demo property export shown in the user's GA4 UI and cannot validate or reproduce the supplied 2026 values. Google says it covers 2020-11-01 through 2021-01-31 and recommends BigQuery Sandbox or the free usage tier for exploration, subject to their limits. [Dataset and usage notes](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset)

## How to run the SQL

1. Sign in to Google Cloud Console with a Google account.
2. Select a Cloud project you own or can use. Do not activate a paid trial or attach billing solely for this project unless you choose to.
3. Open BigQuery Studio and set the query processing location to **US**.
4. Open a SQL file from `sql/`, inspect the bytes-to-process estimate, and run it only if comfortable with the estimate and applicable Sandbox limits.
5. The public source table is read-only; query jobs run in your selected project. Do not substitute `adh-demo-data-review` unless you have been explicitly granted access.

See Google's [BigQuery sample dataset guide](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset) and [GA4 export schema](https://support.google.com/analytics/answer/7029846).

## Important methodological choices

- GA4 interface's `Session key event rate` is not used as purchase conversion because the property has multiple key events (`add_to_cart`, `purchase`, `view_item`, and `xyz`).
- `items_purchased` is units, not order count. Item revenue and total revenue are different measures.
- Funnel SQL is session-based, requires ordered events in the same session, and uses `user_pseudo_id` plus `ga_session_id` as the session key.
- `traffic_source` is first-user attribution in the GA4 export, not session attribution. SQL is labeled accordingly; it does not claim to recreate GA4's default session channel group.
- The funnel screenshots show a very large `add_to_cart` to `begin_checkout` decline. Verify funnel settings and event instrumentation before calling this a checkout defect.
- Inventory, acquisition, product, device/geography, and session-funnel queries have been executed in Sandbox against the public sample. Recorded results and their scope are in [`outputs/bigquery-public-sample-results.md`](outputs/bigquery-public-sample-results.md).

## Project status

The GA4 screenshot analysis and interactive dashboard artifact are complete as a first-pass case study. All five public-sample query areas have run in the user's Cloud Sandbox. The case study is published in this repository; deploying the dashboard as a live site is optional.
