-- Churn Drivers Analysis
-- Analyses churn rates across different contract types and Tech Support availability.

SELECT 
    a.contract_type,
    s.tech_support,
    COUNT(a.customer_id) AS total_customers,
    
    -- Conditional aggregation: count only users who churned ('Yes')
    COUNT(CASE WHEN s.churn_status = 'Yes' THEN 1 END) AS churned_customers,
    
    -- Calculate churn rate percentage
    ROUND(
        (COUNT(CASE WHEN s.churn_status = 'Yes' THEN 1 END) * 100.0) / COUNT(a.customer_id), 
        2
    ) AS churn_rate_pct

FROM account_info a
JOIN services_and_status s 
    ON a.customer_id = s.customer_id
GROUP BY a.contract_type, s.tech_support
ORDER BY churn_rate_pct DESC;