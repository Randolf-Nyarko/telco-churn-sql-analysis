# Subscription Customer Churn & Revenue-at-Risk Analytics (SQL)

## Project Overview
This project focuses on normalising a flat telecommunications dataset, executing data cleaning transformations, and performing exploratory data analysis to identify the key drivers of customer churn and lost Monthly Recurring Revenue (MRR).

**Tools Used:** DB Browser for SQLite, SQL (`CREATE TABLE AS`, `CAST`, `CASE WHEN`, CTEs, Multi-table `JOIN`s)

---

## Database Normalisation & Schema Architecture
The raw dataset originally existed as a single flat CSV (`raw_churn_data`). To follow relational database best practices, I split and normalised the structure into three core relational tables using foreign keys (`customer_id`):

* **`demographics`**: `customer_id`, `gender`, `senior_citizen`, `partner`, `dependents`
* **`account_info`**: `customer_id`, `tenure_months`, `contract_type`, `paperless_billing`, `payment_method`, `monthly_charges`, `total_charges`
* **`services_and_status`**: `customer_id`, `internet_service`, `tech_support`, `streaming_tv`, `churn_status`

---

## Business Questions & Analysis Steps

### 1. Database Architecture & Data Cleaning
* **Problem:** `total_charges` was imported as a text field containing whitespace string errors (`' '`) for customers with 0 months of tenure.
* **Solution:** Applied `TRIM()`, `CASE WHEN` logic, and `CAST(... AS NUMERIC)` to replace blanks with `0.0` and convert the column to numeric data types for calculations.

### 2. Churn Drivers & Contract Risk
* **Problem:** Identify which contract types and service combinations suffer from the highest churn rates.
* **Techniques:** Multi-table `JOIN`s, conditional aggregation (`COUNT(CASE WHEN...)`), percentage calculations.

### 3. Revenue at Risk by Payment Method
* **Problem:** Quantify the exact Monthly Recurring Revenue (MRR) lost to churn and isolate high-risk payment channels.
* **Techniques:** Common Table Expressions (CTEs), subquery division for revenue percentage allocation.

---

## Key Business Insights

1. **Tech Support is a Major Retention Lever:** 
   Customers on **Month-to-Month contracts without Tech Support** exhibit a massive **50.37% churn rate**. By comparison, customers on 2-year contracts churn at under 6% (and just **0.78%** when paired with long-term contracts). Upselling tech support packages or offering incentives for 1-year commitments can significantly cut churn.

2. **Electronic Checks Drive Over 60% of Lost Revenue:** 
   Out of all monthly recurring revenue lost to churn, **60.58% is concentrated in customers using Electronic Checks**. Migrating customers from manual electronic checks to automated credit card auto-pay could reduce friction and lower default/churn rates.

3. **Schema Integrity restored:** 
   Cleaned 11 unbilled customer records (`tenure_months = 0`) where empty space characters prevented numeric aggregation.

---

## How to Run the Analysis
1. Download the [Telco Customer Churn Dataset from Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn).
2. Create an SQLite database and import the raw CSV as `raw_churn_data`.
3. Execute `00_database_normalisation.sql` to build the 3-table relational schema.
4. Run scripts `01` through `03` sequentially to view clean output tables.
