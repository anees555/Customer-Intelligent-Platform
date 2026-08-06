# Customer Intelligence Platform

Customer Intelligence Platform is an end-to-end analytics project built using the Olist Brazilian E-commerce Public Dataset. The objective is to transform raw transactional data into actionable business insights through SQL, Python, statistical analysis, machine learning, and time series forecasting.

The project follows the **CRISP-DM** methodology and is organized into independent analytical modules, allowing each stage—from database design to predictive analytics—to be reviewed separately.

---

# Current Status

**Project Status:** Major analytics modules completed.

Completed modules include:

- ✅ PostgreSQL Database Design & Implementation
- ✅ Data Understanding & Profiling
- ✅ Data Preparation & SQL Analytics
- ✅ Exploratory Data Analysis (SQL & Python)
- ✅ Feature Engineering
- ✅ Customer Segmentation (K-Means)
- ✅ Sales Forecasting (Time Series using SARIMA)
- ✅ Business Interpretation & Reporting

Archived experimental work:

- Customer Churn Prediction (documented with limitations and stored under `notebooks/archives/customer_churn_ML/`)

---

# Project Structure

```text
Customer-Intelligence-Platform/
├── data/
│   ├── raw/
│   │   └── olist-ecommerce-public-dataset/
│   └── processed/
│       ├── customer_features.csv
│       ├── customer_summary_clean.csv
│       ├── order_summary_clean.csv
│       ├── product_features.csv
│       ├── product_summary_clean.csv
│       ├── seller_features.csv
│       ├── seller_summary_clean.csv
│       ├── customer_churn_data/
│       ├── Sales_forcasting_data/
│       └── segments_data/
│
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
│
├── docs/
│   ├── Project_proposal.md
│   ├── business_question.md
│   ├── data_preparation.md
│   ├── data_preprocessing.md
│   ├── data_profiling.md
│   ├── exploratory_data_analysis_sql.md
│   ├── feature_engineering_notes.md
│   └── visual_eda.md
│
├── model/
│   ├── churn_prediction/
│   │   ├── decision_tree.pkl
│   │   ├── logistic_regression.pkl
│   │   ├── random_forest.pkl
│   │   ├── robust_scaler.pkl
│   │   └── xgboost.pkl
│   ├── customer_segmentation/
│   │   ├── kmeans_customer_segmentation.pkl
│   │   └── robust_scaler.pkl
│   └── final_sarima.pkl
│
├── notebooks/
│   ├── 01_data_loading.ipynb
│   ├── 02_data_profiling.ipynb
│   ├── 03_data_preprocessing.ipynb
│   ├── 04_visual_eda.ipynb
│   ├── 05_model_dataset_prep.ipynb
│   │
│   ├── archives/
│   │   └── customer_churn_ML/
│   │       ├── 01_data_preparation.ipynb
│   │       ├── 02_model_training.ipynb
│   │       ├── 03_model_evaluation.ipynb
│   │       └── README.md
│   │
│   |
│   │
│   ├── 01_customer_segmentation/
│   │   ├── 01_data_preparation.ipynb
│   │   ├── 02_kmeans_model.ipynb
│   │   └── 03_cluster_analysis.ipynb
│   │
│   ├── feature_engineering/
│   │   ├── 01_customer_features.ipynb
│   │   ├── 02_product_features.ipynb
│   │   └── 03_seller_features.ipynb
│   │
│   └── Sales_Forcasting/
│       ├── 01_data_preparation.ipynb
│       ├── 02_exploratory_time_series_analyis.ipynb
│       ├── 03_model_training.ipynb
│       ├── 04_model_evaluation.ipynb
│       └── README.md
│
├── reports/
│   └── customer_segmentation_business_interpretation.md
│
├── src/
│   ├── config.py
│   ├── database.py
│   ├── data_loader.py
│   ├── feature_engineering.py
│   ├── preprocessing.py
│   └── utils.py
│
├── tests/
│   └── test_database_connection.py
│
├── requirements.txt
└── README.md
```

---

# Workflow Summary

The project begins with the raw Olist transactional dataset, which is imported into PostgreSQL. Analytical views are then created to simplify customer, order, product, and seller analysis.

Using these curated datasets, multiple analytical modules are developed independently:

- SQL-based exploratory analysis
- Customer feature engineering
- Customer segmentation
- Statistical sales forecasting
- Business interpretation

Each module produces reusable datasets, trained models, and business-oriented insights.

---

# Completed Analytics Modules

## 1. Customer Segmentation

Customer-level behavioral features were engineered from transactional data and standardized before applying K-Means clustering.

The final solution produced five actionable customer segments:

- Premium Customers
- Loyal Customers
- Regular Customers
- Budget Customers
- Dissatisfied Customers

Each segment was interpreted from a business perspective with recommended marketing and retention strategies.

---

## 2. Sales Forecasting

A complete statistical time series forecasting pipeline was developed using weekly revenue.

The workflow includes:

- Weekly revenue aggregation
- Time series decomposition (STL)
- Trend & seasonality analysis
- Stationarity testing (ADF & KPSS)
- Baseline forecasting
  - Naïve Forecast
  - Moving Average
- SARIMA model selection using AIC/BIC
- Forecast evaluation
- Residual diagnostics

Final forecasting model:

```text
SARIMA (1,1,2)
```

Forecast accuracy:

| Model | MAE | RMSE | MAPE |
|------|---------:|---------:|------:|
| Naïve Forecast | 46,751 | 58,303 | 22.99% |
| Moving Average | 46,143 | **55,875** | 21.86% |
| **SARIMA (1,1,2)** | **45,672** | 55,942 | **21.79%** |

---

## 3. Archived Customer Churn Prediction

Customer churn prediction was investigated using multiple feature engineering approaches.

Two different methodologies were explored:

- Recency-based churn labeling
- Time-based cutoff with future observation window

Due to the characteristics of the Olist dataset, almost all customers make only a single purchase and very few customers return within the prediction window. Consequently, the dataset is not suitable for building a meaningful churn prediction model.

Rather than forcing an unrealistic predictive model, the entire experiment has been preserved inside `notebooks/archives/customer_churn_ML/` together with detailed documentation explaining the dataset limitations and reasons for discontinuing the approach.

---

# Key Deliverables

- PostgreSQL database scripts and analytical views
- SQL-based exploratory analysis
- Python feature engineering pipeline
- Customer segmentation model
- Statistical sales forecasting model
- Business interpretation reports
- Archived churn prediction research
- Reusable utility modules

---

# Technologies Used

### Database

- PostgreSQL

### Programming

- Python

### Data Analysis

- Pandas
- NumPy

### Visualization

- Matplotlib
- Seaborn

### Machine Learning

- Scikit-learn
- K-Means Clustering

### Time Series Forecasting

- Statsmodels (SARIMA)

### Development

- Jupyter Notebook

---

# Purpose

This repository demonstrates an end-to-end analytics workflow using a real-world e-commerce dataset.

The project emphasizes not only predictive modeling but also proper database design, feature engineering, statistical analysis, business interpretation, and transparent documentation of experimental work.

All completed modules are fully reproducible, while unsuccessful research directions have been intentionally preserved and documented to demonstrate analytical rigor rather than selectively reporting only successful results.