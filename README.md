# Customer Intelligence Platform

Customer Intelligence Platform is an end-to-end analytics project built on the Olist Brazilian E-commerce dataset. The goal is to turn raw transactional data into clean analytical datasets, customer segments, and business-ready insights that can support decision-making across marketing, operations, and product teams.

The project follows the CRISP-DM workflow and is organized so each stage is easy to review independently, from database design through segmentation analysis.

## Current Status

Current focus: customer segmentation and business interpretation.

Completed work includes database setup, data understanding, analytical view creation, exploratory analysis, feature engineering, and K-Means segmentation.

## Project Structure

```text
Customer-Intelligence-Platform/
├── data/
│   ├── raw/
│   │   └── olist-ecommerce-public-dataset/
│   └── processed/
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_data_understanding.sql
│   ├── 04_data_profiling.sql
│   ├── 05_data_preparation.sql
│   ├── 06_exploratory_data_analysis.sql
│   └── views/
│       ├── customer_summary.sql
│       ├── order_summary.sql
│       ├── product_summary.sql
│       └── seller_summary.sql
├── docs/
│   ├── Project_proposal.md
│   ├── business_question.md
│   ├── data_preparation.md
│   ├── data_preprocessing.md
│   ├── data_profiling.md
│   ├── exploratory_data_analysis_sql.md
│   ├── feature_engineering_notes.md
│   └── visual_eda.md
├── model/
│   └── customer_segmentation/
│       ├── kmeans_customer_segmentation.pkl
│       └── robust_scaler.pkl
├── notebooks/
│   ├── 01_data_loading.ipynb
│   ├── 02_data_profiling.ipynb
│   ├── 03_data_preprocessing.ipynb
│   ├── 04_visual_eda.ipynb
│   ├── 05_model_dataset_prep.ipynb
│   ├── 01_customer_segmentation/
│   │   ├── 01_data_preparation.ipynb
│   │   ├── 02_kmeans_model.ipynb
│   │   └── 03_cluster_analysis.ipynb
│   └── feature_engineering/
│       ├── 01_customer_features.ipynb
│       ├── 02_product_features.ipynb
│       └── 03_seller_features.ipynb
├── reports/
│   └── customer_segmentation_business_interpretation.md
├── src/
│   ├── config.py
│   ├── database.py
│   ├── data_loader.py
│   ├── feature_engineering.py
│   ├── preprocessing.py
│   └── utils.py
├── tests/
│   └── test_database_connection.py
├── requirements.txt
├── .gitignore
└── README.md
```

## Workflow Summary

The project starts with the raw Olist dataset, loads it into PostgreSQL, and creates clean analytical views for orders, customers, products, and sellers. From there, the notebooks under `notebooks/` build feature tables and run customer segmentation with K-Means. The final cluster analysis translates model output into practical business segments.

## Key Deliverables

- Database scripts and analytical views in `database/`
- Documentation and business notes in `docs/`
- Feature engineering and analysis notebooks in `notebooks/`
- Saved segmentation artifacts in `model/customer_segmentation/`
- Written business interpretation in `reports/customer_segmentation_business_interpretation.md`
- Reusable Python utilities in `src/`
- Connection smoke test in `tests/test_database_connection.py`

## Customer Segmentation Outcome

The segmentation work produced five clear customer groups:

- Premium Customers
- Loyal Customers
- Regular Customers
- Budget Customers
- Dissatisfied Customers

These segments are designed to support different business actions. For example, premium customers should be retained with personalized treatment, loyal customers should be rewarded, budget customers should be targeted with value offers, and dissatisfied customers should be prioritized for service and delivery improvement.

## Data Notes

- Processed datasets are stored in `data/processed/`.
- Raw source data is kept in `data/raw/`.
- The local Python environment is managed in `customerenv/`.
- Environment values are read from `.env` through `src/config.py`.

## Run and Review

1. Load the database and generate the analytical views using the SQL scripts in `database/`.
2. Open the notebooks in `notebooks/` to review profiling, feature engineering, and segmentation.
3. Review the final business interpretation in `reports/customer_segmentation_business_interpretation.md`.

## Purpose

This repository is structured to be easy to follow for future reviewers. Each folder has a clear responsibility: raw data in one place, SQL logic in one place, notebooks in one place, saved models in one place, and written insights in one place.