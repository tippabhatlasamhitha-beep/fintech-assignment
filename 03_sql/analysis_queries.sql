-- Query 1: Count transactions by status

SELECT status_clean,
       COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status_clean;


-- Query 2: Total successful GMV by merchant

SELECT merchant_clean,
       SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status_clean = 'SUCCESS'
GROUP BY merchant_clean;


-- Query 3: Top 10 merchants by successful GMV

SELECT merchant_clean,
       SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status_clean = 'SUCCESS'
GROUP BY merchant_clean
ORDER BY total_captured_gmv DESC
LIMIT 10;


-- Query 4: Daily GMV and successful transaction count

SELECT transaction_date,
       SUM(amount_usd) AS daily_gmv,
       COUNT(*) AS successful_transaction_count
FROM cleaned_transactions
WHERE status_clean = 'SUCCESS'
GROUP BY transaction_date
ORDER BY transaction_date;


-- Query 5: Merchants with chargeback ratio above 1%

SELECT merchant_clean,
       COUNT(CASE WHEN status_clean='CHARGEBACK' THEN 1 END)
       *100.0/COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_clean
HAVING chargeback_ratio > 1;


-- Query 6: Regions with average risk score above 50 and more than 20 transactions

SELECT region_clean,
       AVG(risk_score_clean) AS avg_risk_score,
       COUNT(*) AS total_transactions
FROM cleaned_transactions
GROUP BY region_clean
HAVING AVG(risk_score_clean) > 50
   AND COUNT(*) > 20;


-- Query 7: Users with 3 or more FAILED/CHARGEBACK transactions on same day

SELECT user_id,
       transaction_date,
       COUNT(*) AS risky_transactions
FROM cleaned_transactions
WHERE status_clean IN ('FAILED','CHARGEBACK')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;


-- Query 8: Chargeback analysis by merchant

SELECT merchant_clean,
       COUNT(*) AS chargeback_count,
       COUNT(DISTINCT user_id) AS unique_affected_users,
       SUM(amount_usd) AS total_chargeback_amount
FROM cleaned_transactions
WHERE status_clean = 'CHARGEBACK'
GROUP BY merchant_clean;