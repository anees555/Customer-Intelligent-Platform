# Customer Intelligence Platform

## Project Status

**Current Phase:** Data Preparation & Analytical Data Modeling ✅

This project builds an end-to-end Customer Intelligence Platform using the Olist Brazilian E-commerce dataset. The objective is to transform raw transactional data into analytical datasets that support business intelligence, customer analytics, machine learning, and interactive dashboards.

The project follows the **CRISP-DM** methodology to simulate a real-world data engineering and data science workflow.

---

## Current Progress

- [x] Business Understanding
- [x] Dataset Exploration
- [x] Relational Database Design
- [x] PostgreSQL Database Implementation
- [x] Data Import
- [x] Data Understanding & Profiling
- [x] Data Validation
- [x] Data Preparation (Analytical Views)
- [ ] Exploratory Data Analysis (EDA)
- [ ] Feature Engineering
- [ ] Customer Segmentation
- [ ] Machine Learning
- [ ] Dashboard Development
- [ ] Deployment

---

## CRISP-DM Workflow

Business Understanding  ✅
        ↓
Data Understanding      ✅
        ↓
Data Preparation        ✅
        ↓
Modeling                ⏳
        ↓
Evaluation              ⏳
        ↓
Deployment              ⏳

## Project Structure

```text
Customer-Intelligence-Platform/

│
├── data/
│   └── raw/
│       └── olist-ecommerce-public-dataset/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_constraints.sql
│   ├── 03_data_profiling.sql
│   ├── 04_data_validation.sql
│   ├── 05_data_preparation.sql
│   └── views/
│       ├── order_summary.sql
│       ├── customer_summary.sql
│       ├── product_summary.sql
│       └── seller_summary.sql
│
├── docs/
│   ├── database_schema.md
│   ├── data_profiling.md
│   └── data_preparation.md
│
├── notebooks/
├── dashboards/
├── models/
├── reports/
└── README.md
```

---

## Database Design

The PostgreSQL database consists of the following normalized tables:

- customers
- orders
- order_items
- products
- product_categories
- sellers
- order_payments
- order_reviews
- geolocation

The schema uses primary keys, foreign keys, composite keys, and normalization principles to maintain referential integrity.

---

## Data Profiling

After importing the data, each table was profiled to understand its characteristics and quality.

The profiling process included:

- Dataset overview
- Row counts
- Missing value analysis
- Duplicate detection
- Referential integrity validation
- Numerical summaries
- Distribution analysis
- Business-oriented observations

The findings are documented in **`docs/data_profiling.md`**.

---

## Data Preparation

To support business analytics, several analytical views were created:

- **order_summary** – Order-level analytical dataset
- **customer_summary** – Customer-level aggregated metrics
- **product_summary** – Product performance metrics
- **seller_summary** – Seller performance metrics

These views simplify downstream analytics while preserving the normalized transactional database.

The implementation is documented in **`docs/data_preparation.md`**.

---

## Data Quality Challenges

During database implementation, several real-world data quality issues were identified and resolved:

- Missing product category translations (`pc_gamer` and `portateis_cozinha_e_preparadores_de_alimentos`).
- Duplicate records in the `order_reviews` dataset, requiring a revised primary key strategy.
- The `geolocation` dataset lacked a natural primary key, so a surrogate `BIGSERIAL` key was introduced.
- Referential integrity issues were identified and resolved before analytical processing.

---

## Technologies Used

- PostgreSQL
- SQL
- pgAdmin
- Git & GitHub

**Upcoming**

- Python
- Pandas
- Scikit-learn
- Power BI
- Jupyter Notebook

---

## Next Milestone

The next phase focuses on **Exploratory Data Analysis (EDA)** using the analytical views created during the data preparation phase.

The objectives include:

- Customer behavior analysis
- Sales trend analysis
- Product performance analysis
- Seller performance analysis
- Geographic analysis
- KPI development

These insights will later be used for feature engineering, customer segmentation, machine learning, and dashboard development.

---

## Dataset

This project uses the **Olist Brazilian E-commerce Public Dataset**.

1. Download the dataset from Kaggle.
2. Extract the files.
3. Place them in:

```text
data/raw/olist-ecommerce-public-dataset/
```

---

## Project Goal

Build a production-style Customer Intelligence Platform by following the complete CRISP-DM lifecycle, from raw transactional data to business insights, predictive models, and interactive dashboards.