# Customer Intelligence Platform

## Project Status

**Current Phase:** Database Design & Data Loading ✅

This project aims to build an end-to-end Customer Intelligence Platform using the Olist Brazilian E-commerce dataset. The objective is to transform raw transactional data into actionable business insights through SQL, Python, machine learning, and interactive dashboards.

The project follows the CRISP-DM methodology to simulate a real-world data science workflow.

---

## Current Progress

* [x] Business Understanding
* [x] Dataset Exploration
* [x] Relational Database Design
* [x] PostgreSQL Database Implementation
* [x] Data Import
* [ ] Data Understanding
* [ ] Data Cleaning & Preparation
* [ ] Exploratory Data Analysis
* [ ] Feature Engineering
* [ ] Machine Learning
* [ ] Dashboard Development
* [ ] Deployment

---

## Project Structure

```text
Customer-Intelligence-Platform/
│
├── data/
│   ├── raw/
│   
│ 
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_import_data.sql
│   ├── 04_indexes.sql
│   └── 05_views.sql
│
├── notebooks/
├── src/
├── dashboards/
├── reports/
├── models/
└── README.md
```

---

## Database Design

The relational database consists of the following tables:

* customers
* orders
* order_items
* products
* product_categories
* sellers
* order_payments
* order_reviews
* geolocation

The schema was designed in PostgreSQL using primary keys, foreign keys, composite primary keys, and normalization principles.

---

## Data Source

**Dataset:** Olist Brazilian E-commerce Public Dataset

The dataset contains information about customers, orders, products, sellers, payments, reviews, and geolocation data.

---

## Data Quality Challenges Encountered

During database implementation, several real-world data quality issues were identified and resolved:

* Missing product categories in the translation dataset (`pc_gamer` and `portateis_cozinha_e_preparadores_de_alimentos`).
* The `order_reviews` dataset contained duplicate `review_id` and `order_id` values, requiring a composite primary key.
* The `geolocation` table required a surrogate key (`BIGSERIAL`) because the original dataset does not provide a unique identifier.

These issues were documented and resolved while preserving referential integrity.

---

## Next Milestone

The next phase focuses on understanding and profiling the imported data by validating row counts, identifying missing values, detecting duplicates, and assessing data quality before cleaning and feature engineering.


## Dataset

This project uses the Olist Brazilian E-commerce Public Dataset.

1. Download the dataset from Kaggle.
2. Extract the files.
3. Place them in:

data/raw/olist-ecommerce-public-dataset/