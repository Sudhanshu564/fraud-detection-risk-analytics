-- ============================================
-- ADVANCED FRAUD ANALYSIS
-- ============================================


-- 1. High-risk transaction profile

SELECT
    transaction_id,
    amount,
    transaction_hour,
    merchant_category,
    foreign_transaction,
    location_mismatch,
    device_trust_score,
    velocity_last_24h,
    cardholder_age,
    is_fraud
FROM transactions
WHERE
    foreign_transaction = 1
    OR location_mismatch = 1
    OR device_trust_score < 40
ORDER BY
    is_fraud DESC,
    amount DESC;


-- 2. High-risk transactions that combine multiple risk signals

SELECT
    transaction_id,
    amount,
    foreign_transaction,
    location_mismatch,
    device_trust_score,
    velocity_last_24h,
    is_fraud,
    (
        foreign_transaction
        + location_mismatch
        + CASE
            WHEN device_trust_score < 40 THEN 1
            ELSE 0
          END
        + CASE
            WHEN velocity_last_24h > 5 THEN 1
            ELSE 0
          END
    ) AS risk_signal_count
FROM transactions
ORDER BY risk_signal_count DESC;


-- 3. Risk segmentation

WITH risk_scored AS (
    SELECT
        *,
        (
            foreign_transaction
            + location_mismatch
            + CASE
                WHEN device_trust_score < 40 THEN 1
                ELSE 0
              END
            + CASE
                WHEN velocity_last_24h > 5 THEN 1
                ELSE 0
              END
        ) AS risk_score
    FROM transactions
)

SELECT
    CASE
        WHEN risk_score >= 3 THEN 'High Risk'
        WHEN risk_score = 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_segment,
    COUNT(*) AS transactions,
    SUM(is_fraud) AS fraud_transactions,
    ROUND(
        AVG(is_fraud) * 100,
        2
    ) AS fraud_rate_percentage
FROM risk_scored
GROUP BY risk_segment
ORDER BY fraud_rate_percentage DESC;


-- 4. High-value fraudulent transactions

SELECT
    transaction_id,
    amount,
    merchant_category,
    transaction_hour,
    foreign_transaction,
    location_mismatch,
    device_trust_score
FROM transactions
WHERE is_fraud = 1
ORDER BY amount DESC
LIMIT 20;