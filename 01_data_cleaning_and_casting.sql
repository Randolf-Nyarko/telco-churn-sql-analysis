-- Data Cleaning and Type Casting
-- Cleans empty strings in total_charges and casts to NUMERIC/FLOAT.

SELECT 
    customer_id,
    tenure_months,
    monthly_charges,
    raw_total_charges,
    cleaned_total_charges
FROM (
    SELECT 
        customer_id,
        tenure_months,
        monthly_charges,
        total_charges AS raw_total_charges,
        -- Fix empty strings and convert to decimal
        CASE 
            WHEN TRIM(total_charges) = '' OR total_charges IS NULL THEN 0.0
            ELSE CAST(total_charges AS NUMERIC)
        END AS cleaned_total_charges
    FROM account_info
)
WHERE tenure_months = 0 OR raw_total_charges = ' ';