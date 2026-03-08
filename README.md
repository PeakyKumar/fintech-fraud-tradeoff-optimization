# FinTech Fraud Tradeoff Optimization

## Overview

Fraud detection systems in fintech platforms must balance **maximizing fraud capture** while **minimizing false declines that impact legitimate users and revenue**.

This project simulates a fintech transaction environment and analyzes fraud detection thresholds to determine an **optimal decision boundary that maximizes platform profitability**.

The analysis combines **SQL-based data exploration, statistical analysis, and machine learning modeling** to evaluate tradeoffs between fraud loss, customer friction, and operational costs.

---

## Problem Statement

Payment platforms face a critical tradeoff:

- Lower fraud thresholds capture more fraudulent transactions but increase **false declines**
- Higher thresholds improve **customer experience** but allow more fraud losses

The objective of this project is to **identify the optimal fraud decision threshold** that balances fraud capture and business profitability.

---

## Dataset

Synthetic fintech transaction dataset simulating real-world payment behavior.

### Scale

- 50,000+ transactions
- Multiple merchant categories
- User behavioral attributes

### Files

| File | Description |
|-----|-------------|
| transactions.csv | Transaction-level payment data |
| users.csv | User behavioral data |

#### Full dataset removed due to size constraints.Sample dataset included for reproducibility.
---

## Project Structure

```
fintech-fraud-tradeoff-optimization
│
├── SQL_Analysis.sql
├── Transactions_dataset.ipynb
├── User_data.ipynb
├── Model_Training_&_Threshold_Optimization.ipynb
├── transactions.csv
└── users.csv
```

---

## Tech Stack

**Languages**

- Python  
- SQL  

**Libraries**

- Pandas  
- NumPy  
- Scikit-learn  
- Matplotlib  
- Seaborn  

**Tools**

- Jupyter Notebook  

---

## Key Analytical Steps

### Data Exploration

- Fraud distribution across merchant categories
- Transaction amount pattern analysis
- Behavioral fraud indicators

### Feature Engineering

- Transaction frequency
- Spending patterns
- Merchant interaction behavior
- Time-based behavioral signals

### Fraud Modeling

Baseline fraud detection models were trained to identify high-risk transactions.

Models explored:

- Logistic Regression
- Tree-based classifiers

Evaluation metrics:

- ROC-AUC
- Precision
- Recall

---

## Threshold Optimization

Fraud detection thresholds were simulated to analyze the tradeoff between:

- Fraud capture rate
- False decline rate
- Customer friction
- Platform revenue impact

The optimal threshold balances **fraud prevention and customer experience**.

---

## Key Insights

- Fraud behavior varies significantly across merchant categories.
- Transaction patterns provide strong signals for fraud detection.
- Threshold optimization improves fraud capture while minimizing customer friction.

---

## How to Run

Clone the repository:

```
git clone https://github.com/PeakyKumar/fintech-fraud-tradeoff-optimization.git
```

Install dependencies:

```
pip install pandas numpy scikit-learn matplotlib seaborn
```

Run notebooks in order:

1. Transactions_dataset.ipynb  
2. User_data.ipynb  
3. Model_Training_&_Threshold_Optimization.ipynb  

---

## Business Impact

Fraud detection optimization helps fintech platforms:

- Reduce fraud losses
- Improve payment success rates
- Maintain customer trust
- Optimize operational costs

This project demonstrates how **data analytics and machine learning can support risk management strategies in digital payment ecosystems**.

---

## Author

**Naman Chawla**

GitHub:  
https://github.com/PeakyKumar
