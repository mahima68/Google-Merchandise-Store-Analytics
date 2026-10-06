# Business question coverage

This page answers the original questions using the supplied GA4 screenshots and, where noted, Google's separate public BigQuery sample. The GA4 screenshots are from around September–October 2026; the public sample covers November 1, 2020–January 31, 2021. Keep those sources separate.

## Acquisition

| Business question | Current answer | Coverage |
|---|---|---|
| Where do users come from? | In the supplied GA4 Traffic acquisition report, users arrive through Direct, Organic Search, Paid Search, Referral, Cross-network, Organic Shopping, Organic Social, Organic Video, Email, and Unassigned. A complete source/medium and campaign table was not supplied. | Answered at channel-group level; detailed sources/campaigns remain unavailable in the supplied extract. |
| Which acquisition channels generate the most traffic? | Direct is largest with **80,809 sessions (62.2%)**; Organic Search follows with **33,740 (26.0%)**. | Answered from the latest Traffic acquisition screenshot. |
| Which channels generate the most revenue? | Direct leads with **$180,633.62 (56.37%)**; Organic Search follows with **$99,795.72 (31.15%)**. | Answered from that same screenshot. |
| Which channels have the highest conversion rates? | In the separate initial channel table, the supplied user purchase rate (purchasers ÷ active users) is highest for Referral (**6.26%**, 80 / 1,278), followed by Organic Social (**5.32%**, 21 / 395). Referral has the larger base; Social is a small sample. | Answered for that table's user-based definition. The later Session key event rate is not purchase-only because multiple events are marked as key events. The funnel channel breakdown is a different checkout-to-purchase measure and must remain separate. |

## User behavior

| Business question | Current answer | Coverage |
|---|---|---|
| How engaged are users? | The overview reports **1m 13s** average active-user engagement, **55s** average session engagement, and **0.55** engaged sessions per active user. By channel, Organic Shopping has the highest engagement rate (**85.13%**) in the latest channel report; Direct is **29.65%**. | Answered from separate overview and channel extracts; their periods/denominators are not assumed to match. |
| Which devices do users use? | Web is the only platform shown. Device category is **63.6% mobile**, **35.7% desktop**, and **0.7% tablet**. | Answered from the GA4 Tech report. |
| Which countries generate the most users? | “(not set)” is the largest row (**40,325 users**, 40.86%), indicating substantial missing location classification. Among named countries, the **United States** leads (**29,553**), followed by India (**5,360**) and Japan (**3,511**). | Answered with a significant missing-country caveat. |
| Where do users drop out of the shopping journey? | The supplied channel funnel shows its largest decline between begin_checkout and purchase: **959 of 83,252 checkout users** reach purchase (**1.15%** reported completion; **98.85%** abandonment). | The reported location of the drop is clear, but its cause is not. Funnel screenshots have different dates/settings and some displayed counts/abandonments do not reconcile; event payloads have not been validated. |

## E-commerce

| Business question | Current answer | Coverage |
|---|---|---|
| Which products are purchased most frequently? | In the supplied GA4 E-commerce purchases report, Chrome Dino Gradient Sparkle Sticker leads with **995 items**, followed by Google Sticker (**936**) and Google Pen White (**828**). | Answered; these are item quantities, not order counts. |
| Which products generate the most revenue? | Google Marine Layer 1998 Pullover leads with **$19,350** (189 items), followed by Google Timbuk2 Tuck Backpack (**$8,605.60**) and Google Wellfleet 1/2 Zip (**$6,983.60**). | Answered from the GA4 item report. |
| Which products have high views but low purchases? | The GA4 report shows Google Recycled Black Hoodie at **2,459 views and 14 items purchased** (0.57 items/view), and the Marine Layer Pullover at **6,583 views and 189 items** (2.87 items/view). | Answered as a screening comparison, not a unique-shopper conversion rate. Review the same date range and stock/size availability before acting. |

## Funnel

| Business question | Current answer | Coverage |
|---|---|---|
| How many users progress from product viewing to purchase? | One supplied channel exploration reports **83,710** at view_item, **83,310** at add_to_cart, **83,252** at begin_checkout, and **959** at purchase. A different device exploration reports **86,056** at view and **962** purchases. | Counts are available, but the explorations have different settings/date windows and must not be combined into one funnel. |
| At which stage do users drop off? | Both supplied screenshots point to the largest reported loss at **begin_checkout → purchase**. One channel view reports **98.85% abandonment** at that step. | Answered as a report signal; reconcile the exploration settings and validate purchase tracking before treating it as a measured checkout failure. |
| Does funnel performance differ by channel, device, or country? | Yes in the supplied breakdowns. The device screenshot reports checkout-to-purchase completion of **3.43% desktop**, **0.16% mobile**, and **0.81% tablet**. The channel screenshot reports about **3.19% Referral**, **1.20% Direct**, **1.02% Organic Search**, and **0.15% Paid Search**. The country view reports **4.15% United States**, **1.65% Canada**, **0.07% India**, and **0.06% Japan**. | Differences are visible, but the large “(not set)” country group, small segments, inconsistent displayed counts, and unaligned exploration settings limit interpretation. |

## What the public BigQuery work adds

The public BigQuery sample work provides independently executed SQL for inventory, first-user source/medium, device/geography, item performance, and a strictly ordered session funnel. It is a reproducible SQL case study, but it does **not** fill missing fields in the 2026 GA4 extracts and does **not** validate the demo property's tracking. Results and metric definitions are in [the captured results report](../outputs/bigquery-public-sample-results.md).

## Remaining verification

The original question set is answered at the level supported by the screenshots and public sample. These are evidence/access limits, not unanswered SQL tasks:

- The actual BigQuery export linked to the GA4 demo property is in a Cloud project the analyst does not own or have access to. Its tables and raw event payloads cannot be queried here.
- Ecommerce event implementation, purchase transaction IDs, currency/value/item payloads, and deduplication have not been verified.
- The GA4 funnel explorations have differing date ranges/settings, and some displayed counts/abandonments are internally inconsistent.
- The supplied GA4 extracts do not include full session source/medium and campaign detail, advertising spend, margin, inventory, or experiment results.
- Both dashboards are static snapshots; they do not refresh automatically from GA4 or BigQuery.

These limits are also summarized in [the verification checklist](ga4-verification-checklist.md) and [the findings report](../analysis/findings.md).
