# Sales Forecasting using Time Series Analysis

## Project Overview

This project develops a univariate time series forecasting pipeline to predict future weekly sales revenue using the Olist Brazilian E-commerce Public Dataset. The objective is to analyze historical sales patterns, identify underlying temporal structures, and build an interpretable forecasting model capable of estimating future business revenue.

Unlike many forecasting projects that rely solely on machine learning models, this project follows a traditional statistical forecasting workflow. It includes comprehensive exploratory time series analysis, stationarity testing, benchmark forecasting models, SARIMA model selection, forecast evaluation, and residual diagnostics.

The project emphasizes reproducible methodology and model interpretability rather than pursuing marginal improvements through excessive model tuning.

---

## Business Problem

Accurate sales forecasting enables businesses to:

- Estimate future revenue
- Support inventory planning
- Improve operational decision-making
- Allocate marketing resources effectively
- Anticipate seasonal demand fluctuations

The objective of this project is to forecast weekly sales revenue based only on historical transaction data.

---

## Dataset

**Dataset:** Olist Brazilian E-commerce Public Dataset

The forecasting dataset was created by integrating:

- `olist_orders_dataset`
- `olist_order_items_dataset`
- `olist_order_payments_dataset`

Weekly sales revenue was calculated by aggregating total payment values based on order purchase dates.

---

## Project Workflow

```
Raw Transaction Data
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Weekly Revenue Aggregation
        │
        ▼
Exploratory Time Series Analysis
        │
        ├── Trend Analysis
        ├── Seasonality Analysis
        ├── STL Decomposition
        ├── Rolling Statistics
        ├── Distribution Analysis
        └── Outlier Detection
        │
        ▼
Stationarity Testing
        │
        ├── Augmented Dickey-Fuller Test
        └── KPSS Test
        │
        ▼
Train / Test Split
        │
        ▼
Baseline Forecast Models
        │
        ├── Naïve Forecast
        └── Moving Average
        │
        ▼
SARIMA Model Selection
        │
        ▼
Forecast Generation
        │
        ▼
Model Evaluation
        │
        ├── MAE
        ├── RMSE
        ├── MAPE
        └── Residual Diagnostics
```

---

## Project Structure

```text
sales_forecasting/
│
├── notebooks/
│   ├── 01_data_preparation.ipynb
│   ├── 02_exploratory_time_series_analysis.ipynb
│   ├── 03_model_training.ipynb
│   └── 04_model_evaluation.ipynb
│
├── data/
│   ├── processed/
│   └── forecasts/
│
├── models/
│   └── final_sarima.pkl
│
├── reports/
│
└── README.md
```

---

## Exploratory Time Series Analysis

The following analyses were performed before model development:

- Weekly and monthly revenue aggregation
- Trend analysis
- Seasonal decomposition using STL
- Rolling 4-week and 8-week moving averages
- Revenue and order distributions
- Outlier detection
- Autocorrelation (ACF)
- Partial autocorrelation (PACF)
- Stationarity testing using:
  - Augmented Dickey-Fuller (ADF)
  - KPSS

The analysis showed:

- Strong long-term upward trend
- Weak weekly seasonality
- One significant revenue spike during Black Friday
- Non-stationary series requiring first-order differencing

---

## Forecasting Models

Three forecasting approaches were evaluated.

### Baseline Models

- Naïve Forecast
- 4-Week Moving Average

### Statistical Model

- SARIMA

Multiple SARIMA configurations were trained and compared using Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC).

The final selected model was:

```text
SARIMA (1,1,2)
```

---

## Model Performance

| Model | MAE | RMSE | MAPE |
|------|---------:|---------:|------:|
| Naïve Forecast | 46,751 | 58,303 | 22.99% |
| Moving Average | 46,143 | **55,875** | 21.86% |
| **SARIMA (1,1,2)** | **45,672** | 55,942 | **21.79%** |

The SARIMA model achieved the lowest Mean Absolute Error (MAE) and Mean Absolute Percentage Error (MAPE), while performing comparably to the Moving Average model in terms of RMSE.

---

## Residual Diagnostics

Model residuals were evaluated using the Ljung–Box test.

**Result**

- p-value = **0.227**

Since the p-value is greater than 0.05, the residuals behave approximately as white noise, indicating that the model successfully captured the primary temporal structure present in the historical sales data.

---

## Key Findings

- Weekly revenue exhibits a clear long-term growth trend.
- Seasonality exists but is relatively weak.
- Black Friday creates a significant sales spike.
- First-order differencing successfully transforms the series into a stationary process.
- SARIMA slightly outperforms simple benchmark models while maintaining statistical validity.
- For this dataset, a relatively simple statistical model provides competitive forecasting performance.

---

## Limitations

Several characteristics of the Olist dataset limit forecasting performance:

- The usable time series contains only approximately **86 weekly observations**, which is relatively short for time series forecasting.
- Revenue is influenced by business events such as promotions and Black Friday, but no external variables describing these events are available.
- The forecasting model is univariate and therefore cannot incorporate factors such as marketing campaigns, holidays, pricing strategies, or economic conditions.
- The final weeks of the dataset contain incomplete data collection, requiring exclusion from model training and evaluation.

---

## Future Improvements

Potential extensions of this project include:

- Incorporating external regressors (SARIMAX)
- Comparing with Prophet forecasting
- Gradient Boosting models using lag features
- Deep learning models such as LSTM or Temporal Fusion Transformer
- Forecasting product-category or seller-level revenue
- Multi-step probabilistic forecasting

---

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Statsmodels
- Scikit-learn
- Jupyter Notebook

---

## Conclusion

This project demonstrates a complete statistical time series forecasting workflow, beginning with raw transactional data and ending with an evaluated forecasting model. Rather than focusing solely on predictive accuracy, the project emphasizes sound analytical methodology through exploratory analysis, stationarity assessment, benchmark comparisons, principled SARIMA model selection, and residual diagnostics.

The resulting SARIMA model provides an interpretable forecasting solution that slightly outperforms simple baseline methods while satisfying key statistical assumptions. Although forecasting accuracy is constrained by the limited history and lack of external business variables, the project reflects a realistic and production-oriented approach to sales forecasting using real-world e-commerce data.