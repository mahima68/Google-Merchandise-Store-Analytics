# Findings and Recommendations

## Executive summary

The supplied GA4 reports indicate that Direct and Organic Search provide most of the site's traffic and revenue. Referral and Organic Social have stronger reported revenue per session than the largest channels, but their traffic bases are much smaller. Mobile supplies most users, yet the supplied funnel shows substantially weaker mobile progression from checkout start to purchase than desktop. Product reporting separates high unit volume from high revenue: small accessories sell frequently, while apparel and selected higher-priced products contribute more revenue.

The largest funnel signal is an unusually severe drop between `begin_checkout` and `purchase`. Treat this as a measurement and journey-investigation priority, not as proof of a broken checkout. Multiple reports have differing funnel settings/date windows, and event instrumentation has not been validated.

## Acquisition and channel performance

The latest supplied Traffic acquisition report totals 129,908 sessions and $320,420.82 in revenue. Direct contributes 80,809 sessions (62.2%) and $180,633.62 (56.37%). Organic Search contributes 33,740 sessions (25.97%) and $99,795.72 (31.15%). Together they account for about 88.2% of sessions and 87.5% of revenue.

Among larger channels, Referral reports $6.57 revenue per session and a 70.28% engagement rate across 2,251 sessions; Organic Search reports $2.96 per session across 33,740 sessions. Organic Social reports $16.03 per session, but only 699 sessions, so treat the rate as volatile. Paid Search reports $1.17 per session, 34.01% engagement, and 20 seconds average engagement across 6,254 sessions; investigate its targeting, landing pages, and traffic quality before changing spend.

The channel screenshot reports Session key event rate, which is not a purchase-only rate for this property. The earlier channel table's Purchasers ÷ Active Users can answer a user-based purchase-rate question, but it is a different report slice and must not be combined with the later session-channel table as if they were one extract.

## Engagement and devices

The Engagement overview reports 1m 13s average active-user engagement and 0.55 engaged sessions per active user. The Tech overview shows 63.6% mobile, 35.7% desktop, and 0.7% tablet users. This makes the mobile experience high priority for review, but traffic share alone does not establish that a device is underperforming.

## Geography

The demographic table reports 98,681 active users and $320,420.82 total revenue. The United States has 29,553 active users (29.95%) and $293,769.81 revenue (91.68%). India has 5,360 users and $820.58 revenue; Canada has 1,758 users and $9,710.18. `(not set)` has 40,325 users (40.86%) and no revenue, so geography reporting has a major classification gap and should be interpreted with care.

The GA4 anomaly card flags a United States traffic spike on September 28, 2026. This automated insight is a prompt to inspect the underlying date/channel/page data, not a validated explanation.

## Product performance

The item report totals 21,303 items purchased and $298,474.21 item revenue. By unit volume, Chrome Dino Gradient Sparkle Sticker leads with 995 units, followed by Google Sticker (936) and Google Pen White (828). By item revenue, Google Marine Layer 1998 Pullover leads at $19,350 (189 units), followed by Google Timbuk2 Tuck Backpack at $8,605.60 (86 units), Google Wellfleet 1/2 Zip at $6,983.60 (110 units), Google Nantucket Sweatshirt at $6,982.80 (125 units), and Google Stripe Picnic Blanket at $6,770 (169 units).

The Marine Layer Pullover is the clearest high-interest/low-purchase follow-up: 6,583 item views but 189 units purchased (2.87% item purchase-to-view ratio). Google Recycled Black Hoodie has 2,459 views and 14 purchases (0.57%) and only 83 cart additions. These item ratios compare quantities, not unique shoppers; they are screening signals rather than conversion rates.

## Funnel and segment signals

The supplied channel funnel reports 83,710 users at `view_item`, 83,310 at `add_to_cart`, 83,252 at `begin_checkout`, and 959 at `purchase`. The report shows 99.52% completion from view to cart, 99.93% from cart to checkout, then 1.15% from checkout to purchase (98.85% abandonment). The device version shows 962 purchases from 86,032 checkout starters (1.12%). The snapshots do not share a confirmed common date range/configuration, so don't reconcile their totals directly.

In the device breakdown, 856 of 24,930 desktop users who begin checkout purchase (3.43%); for mobile, 101 of 61,327 (0.16%); tablet shows 5 of 616 (0.81%). In the channel breakdown, Referral is highest among the displayed meaningful channels at about 3.19% checkout-start-to-purchase; Direct is about 1.20%, Organic Search 1.02%, and Paid Search 0.15%. Country breakdown shows United States at 4.15%; India 0.07%; Canada 1.65%. Small populations and the very large `(not set)` group matter when interpreting these rates.

Some supplied funnel rows appear internally inconsistent: for example a channel's step-1/step-2 counts do not always agree with the displayed abandonment count, and one channel view shows 99.52% at `view_item` while the Direct row's displayed counts imply a different denominator. Treat values as copied from their GA4 screenshots and re-export the same funnel configuration/date range before final presentation.

## Recommended next steps

1. **Validate ecommerce instrumentation and funnel settings.** Confirm each event fires at the intended action; inspect event counts, sequence rules, open/closed funnel, time window, and date range. Verify `begin_checkout` and `purchase` transaction IDs/value/currency/item payloads.
2. **Investigate mobile checkout progression.** Compare mobile and desktop checkout steps, page load behavior, payment options, form errors, and purchase event firing. Use a controlled QA session; don't infer the cause from GA4 alone.
3. **Review the product detail page for the Marine Layer Pullover and Black Hoodie.** Check size/stock availability, shipping/returns clarity, price, imagery, and add-to-cart instrumentation. Validate views/cart/purchases with the same report period.
4. **Audit acquisition quality.** Review source/medium, campaigns, landing pages, and paid search targeting. Scale referral/social only after confirming stable performance at more volume; assess Paid Search with spend and campaign context before reallocating budget.
5. **Address location attribution coverage.** Investigate why `(not set)` is so large, confirm consent/tag behavior, and avoid treating missing geography as a real market segment.

## Limits

- GA4 interface screenshots are user-supplied and not raw exports; exact date filters are missing from some screenshots.
- BigQuery event export from the demo property's linked Cloud project was not accessible in the account used here.
- BigQuery queries target Google's separate obfuscated public sample, not the 2026 screenshot data. All five planned query areas have run. The acquisition, corrected product-name rankings, and ranked device/country purchase summaries are recorded. Product rankings were rerun to resolve a mismatch in the previously transcribed unit list, and a follow-up label audit recovered all full product names. The recorded output is limited to top-10 rankings and a selected high-view/low-unit shortlist, as documented in `outputs/bigquery-public-sample-results.md`.
- No cost/spend, margin, inventory, site performance, or experiment data was supplied; recommendations are hypotheses to investigate.
- Revenue values in different GA4 reports may use different scopes (total revenue versus item revenue) and are not directly interchangeable.

## Separate BigQuery findings — public obfuscated sample (2020-11-01 to 2021-01-31)

These are results from Google's public obfuscated ecommerce sample, queried in the user's BigQuery Sandbox project. They are a distinct analysis from the 2026 GA4 interface extracts above.

- Inventory query returned **4,295,584 event rows**, **270,154 pseudonymous users**, and **17 event names** for the sample period.
- First-user source/medium query returned 12 rows. The latest executed query ranked `google / organic` first with $86,645 from 1,484 purchase events, followed by `(direct) / (none)` with $79,196 from 1,211 events, `(data deleted) / (data deleted)` with $54,128 from 760 events, and `shop.googlemerchandisestore.com / referral` with $47,318 from 708 events. This uses the export's **first-user** `traffic_source`, not GA4 session-channel attribution. Treat the `(data deleted)` row cautiously because source data is masked.
- The corrected product query aggregates on item name because the same named product can have different item IDs across event rows. By item revenue, Google Zip Hoodie F/C leads at **$13,788** (273 units), followed by Google Crewneck Sweatshirt Navy at **$10,714** (236 units), Google Men's Tech Fleece Grey at **$9,965** (134 units), Google Badge Heavyweight Pullover Black at **$9,712** (201 units), and Super G Unisex Joggers at **$9,529** (308 units). By unit volume, Google Clear Pen 4-Pack leads with **444 units**, followed by Google Laptop and Cell Phone Stickers (416) and Google Metallic Notebook Set (365). Among the top-view products, Google Women's Striped L/S has 42,142 views and 0 units; Google F/C Long Sleeve Tee has 34,275 views and 0 units; Google Campus Bike Eco Tee has 43,140 views and 56 units. These are item-name rollups from the public sample; units/view-event ratios are not unique-shopper conversion rates. The product ranking was rerun and full labels were audited; the current full top-10 tables are in `outputs/bigquery-public-sample-results.md`.
- The revised custom **session-based** funnel counted 77,020 sessions with `view_item`, 14,380 with a subsequent `add_to_cart`, 5,187 with a subsequent `begin_checkout`, and 2,778 with a subsequent `purchase`. Continuation was **18.67%**, **36.07%**, and **53.56%**; **3.61%** of view sessions reached purchase. Desktop had 1,567 purchases from 2,975 checkout sessions (52.67%); mobile had 1,150 from 2,101 (54.74%). The United States led the captured country rows with 1,225 purchases from 2,282 checkout sessions (53.68%). This differs from GA4's user-based Funnel Exploration and is not directly comparable to the screenshot funnel.
- The completed public-sample segment query ranks devices, countries, and device/country pairs by distinct users while preserving session-start events, purchase events, and purchase revenue. Desktop leads overall (158,917 users; 3,226 purchase events; $208,815 purchase revenue). The United States leads countries (118,493 users; $160,573), while desktop/United States is the largest combined segment (69,827 users; 1,413 purchases; $94,560). Complete captured top-10 tables are in [`../outputs/bigquery-public-sample-results.md`](../outputs/bigquery-public-sample-results.md).
