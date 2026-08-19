-- ============================================
-- RISK ANALYSIS
-- ============================================


-- 1. Fraud rate by foreign transaction

SELECT
    foreign_transaction,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM transactions
GROUP BY foreign_transaction
ORDER BY fraud_rate_percentage DESC;


-- 2. Fraud rate by location mismatch

SELECT
    location_mismatch,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM transactions
GROUP BY location_mismatch
ORDER BY fraud_rate_percentage DESC;


-- 3. Device trust and fraud

SELECT
    is_fraud,
    COUNT(*) AS transactions,
    ROUND(AVG(device_trust_score), 2) AS average_device_trust,
    ROUND(AVG(velocity_last_24h), 2) AS average_velocity
FROM transactions
GROUP BY is_fraud;


-- 4. Fraud rate by transaction hour

SELECT
    transaction_hour,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM transactions
GROUP BY transaction_hour
ORDER BY fraud_rate_percentage DESC;


-- 5. Fraud rate by merchant category

SELECT
    merchant_category,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM transactions
GROUP BY merchant_category
ORDER BY fraud_rate_percentage DESC;