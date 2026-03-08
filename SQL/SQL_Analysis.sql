CREATE DATABASE fraud_growth_db;
USE fraud_growth_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    user_segment VARCHAR(20),
    avg_monthly_spend FLOAT,
    base_churn_prob FLOAT,
    tenure_days INT,
    lifetime_value FLOAT
);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    transaction_date DATE,
    amount FLOAT,
    merchant_category VARCHAR(50),
    device_risk_score FLOAT,
    geo_risk_score FLOAT,
    is_fraud INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#preview of the data
SELECT *
FROM users
LIMIT 10;

	SELECT *
	FROM transactions
	LIMIT 10;

SELECT COUNT(*) AS total_users
FROM users;

# Overall Fraud Rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(AVG(is_fraud) * 100, 3) AS fraud_rate_percent
FROM transactions;

#Fraud Rate by Merchant Category
SELECT
    merchant_category,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 2) AS fraud_rate_percent
FROM transactions
GROUP BY merchant_category
ORDER BY fraud_rate_percent DESC;

#Fraud Rate by User Segment
SELECT
    u.user_segment,
    COUNT(*) AS transactions,
    SUM(t.is_fraud) AS fraud_cases,
    ROUND(AVG(t.is_fraud) * 100, 2) AS fraud_rate_percent
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.user_segment
ORDER BY fraud_rate_percent DESC;

#Average Transaction Amount by Segment
SELECT
    u.user_segment,
    ROUND(AVG(t.amount),2) AS avg_transaction_amount
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.user_segment;

#Transaction Volume by User Segment
SELECT
    u.user_segment,
    COUNT(*) AS transaction_count
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.user_segment;

#Revenue Contribution by Segment
SELECT
    u.user_segment,
    COUNT(*) AS transactions,
    ROUND(SUM(t.amount),2) AS total_volume,
    ROUND(SUM(t.amount * 0.025),2) AS platform_revenue
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
WHERE t.is_fraud = 0
GROUP BY u.user_segment
ORDER BY platform_revenue DESC;

#Fraud Rate by Transaction Amount Bucket
SELECT
    CASE
        WHEN amount < 50 THEN '0-50'
        WHEN amount < 200 THEN '50-200'
        WHEN amount < 500 THEN '200-500'
        ELSE '500+'
    END AS amount_bucket,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 2) AS fraud_rate_percent
FROM transactions
GROUP BY amount_bucket
ORDER BY fraud_rate_percent DESC;

#Fraud Loss Estimate
SELECT
    ROUND(SUM(amount),2) AS total_fraud_loss
FROM transactions
WHERE is_fraud = 1;

#Platform Revenue vs Fraud Loss
SELECT
    ROUND(SUM(CASE WHEN is_fraud = 0 THEN amount * 0.025 ELSE 0 END),2) AS revenue,
    ROUND(SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END),2) AS fraud_loss
FROM transactions;

#Fraud Exposure by User Segment
SELECT
    u.user_segment,
    ROUND(SUM(CASE WHEN t.is_fraud = 1 THEN t.amount ELSE 0 END),2) AS fraud_loss
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.user_segment
ORDER BY fraud_loss DESC;

#High Value Users
SELECT
    user_id,
    lifetime_value
FROM users
ORDER BY lifetime_value DESC
LIMIT 10;

#Most Active Users
SELECT
    user_id,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY user_id
ORDER BY transaction_count DESC
LIMIT 10;

#Join Validation
SELECT
    t.transaction_id,
    u.user_segment,
    t.amount,
    t.is_fraud
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
LIMIT 20;
