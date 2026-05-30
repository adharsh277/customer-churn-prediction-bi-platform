-- Example analysis queries
-- 1) Churn rate
SELECT
  COUNT(*) FILTER (WHERE churned) AS churned_count,
  COUNT(*) AS total_customers,
  ROUND(100.0 * COUNT(*) FILTER (WHERE churned) / NULLIF(COUNT(*),0), 2) AS churn_rate_pct
FROM customers;

-- 2) Monthly revenue by plan
SELECT s.plan, DATE_TRUNC('month', s.start_date) AS month, SUM(s.monthly_fee) AS revenue
FROM subscriptions s
GROUP BY 1,2
ORDER BY 2 DESC;
