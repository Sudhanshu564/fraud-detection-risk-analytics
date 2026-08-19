-- ============================================
-- FRAUD DETECTION & RISK ANALYTICS
-- Transaction Analysis
-- ============================================


-- 1. Total number of transactions

SELECT
    COUNT(*) AS total_transactions
FROM transactions;


-- 2. Total transaction value

SELECT
    ROUND(SUM(amount), 2) AS total_transaction_value
FROM transactions;


-- 3. Average transaction amount

SELECT
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM transactions;


-- 4. Transaction count by fraud status

SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY is_fraud;


-- 5. Fraud rate

SELECT
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM transactions;


-- 6. Average transaction amount by fraud status

SELECT
    is_fraud,
    COUNT(*) AS transaction_count,
    ROUND(AVG(amount), 2) AS average_amount,
    ROUND(MIN(amount), 2) AS minimum_amount,
    ROUND(MAX(amount), 2) AS maximum_amount
FROM transactions
GROUP BY is_fraud;


-- 7. Transactions by merchant category

SELECT
    merchant_category,
    COUNT(*) AS transaction_count,
    ROUND(AVG(amount), 2) AS average_amount
FROM transactions
GROUP BY merchant_category
ORDER BY transaction_count DESC;