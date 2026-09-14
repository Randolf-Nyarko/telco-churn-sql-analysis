-- Revenue at Risk & Payment Method Analysis
-- Calculates total monthly recurring revenue (MRR) lost to churned customers by payment method.

WITH ChurnedRevenue AS (
    -- Calculate total churned customers and MRR lost per payment method
    SELECT 
        a.payment_method,
        COUNT(a.customer_id) AS churned_customers,
        ROUND(SUM(a.monthly_charges), 2) AS lost_monthly_revenue
    FROM account_info a
    JOIN services_and_status s 
        ON a.customer_id = s.customer_id
    WHERE s.churn_status = 'Yes'
    GROUP BY a.payment_method
)
-- Calculate each payment method's share of total lost revenue
SELECT 
    payment_method,
    churned_customers,
    lost_monthly_revenue,
    ROUND(
        (lost_monthly_revenue / (SELECT SUM(lost_monthly_revenue) FROM ChurnedRevenue)) * 100, 
        2
    ) AS pct_total_mrr_lost
FROM ChurnedRevenue
ORDER BY lost_monthly_revenue DESC;