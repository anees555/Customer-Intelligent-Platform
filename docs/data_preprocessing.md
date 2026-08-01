# Customer, Order, Product, and Seller Data Preprocessing Summary

## Customer Summary

### Key Actions
- Converted monetary, review, and delivery metrics to `float`; dates to `datetime`; identifiers to `string`.
- Missing values:
  - **Delivery days (2.16%)** → Retained (valid for cancelled/undelivered orders).
  - **Review scores (0.73%)** → Retained (customers chose not to review).
  - **Revenue values (<0.01%)** → Removed (invalid financial record).
- No duplicates found.
- Outliers (spending, orders, delivery times, reviews) → Retained (reflect genuine customer behavior).

**Decision:** Only one invalid record removed; all other values preserved.

---

## Order Summary

### Key Actions
- Converted all columns to appropriate data types.
- Missing values:
  - **Delivery-related fields (2.22%)** → Retained (orders not delivered).
  - **Review scores (0.76%)** → Retained (no review submitted).
  - **Order approved at (0.01%)** → Retained (minor inconsistency).
  - **Payment values (1 record)** → Corrected using business rule:  
    `total_payment = total_product_price + total_freight`  
    `product_payment = total_product_price`
- No duplicates found.
- Outliers (payment, freight, items, reviews, delivery times) → Retained (valid marketplace behavior).

**Decision:** Corrected one payment record; all other data retained.

---

## Product Summary

### Key Actions
- Converted numeric columns to `int64/float64`; product ID retained as `string`.
- Missing values:
  - **Category (1.85%)** → Retained (no original category available).
  - **Review scores (0.49%)** → Retained (no reviews submitted).
  - **Delivery days (2.24%)** → Retained (orders not delivered).
- No duplicates found.
- Outliers (orders, revenue, freight, prices, reviews, delivery times) → Retained (represent genuine product performance).

**Decision:** No records removed; missing values preserved.

---

## Seller Summary

### Key Actions
- Converted numeric columns to `int64/float64`; identifiers retained as `string`.
- Missing values:
  - **Review scores (0.16%)** → Retained (no reviews).
  - **Delivery days (4.04%)** → Retained (no successful deliveries).
- No duplicates found.
- Outliers (orders, revenue, freight, prices, reviews, delivery times) → Retained (reflect seller performance differences).

**Decision:** No records removed; missing values preserved.

---

## Final Decisions

| Dataset   | Action Taken | Reason |
|-----------|--------------|--------|
| Customer  | Removed 1 invalid record | Missing essential financial values |
| Order     | Corrected 1 payment record | Reconstructed using product + freight |
| Product   | Retained all records | Missing values valid business scenarios |
| Seller    | Retained all records | Missing values valid business scenarios |

---

## Overall Summary
Across all datasets, preprocessing confirmed high data quality. Most missing values and outliers represent valid business scenarios and were preserved to maintain integrity. Only one customer record was removed and one order record corrected.
