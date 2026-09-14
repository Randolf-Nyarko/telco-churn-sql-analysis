-- Create the Demographics Table
CREATE TABLE demographics AS
SELECT 
    customerID AS customer_id, 
    gender, 
    SeniorCitizen AS senior_citizen, 
    Partner AS partner, 
    Dependents AS dependents
FROM raw_churn_data;

-- Create the Account Info Table
CREATE TABLE account_info AS
SELECT 
    customerID AS customer_id, 
    tenure AS tenure_months, 
    Contract AS contract_type, 
    PaperlessBilling AS paperless_billing, 
    PaymentMethod AS payment_method, 
    MonthlyCharges AS monthly_charges, 
    TotalCharges AS total_charges
FROM raw_churn_data;

-- Create the Services & Status Table
CREATE TABLE services_and_status AS
SELECT 
    customerID AS customer_id, 
    InternetService AS internet_service, 
    TechSupport AS tech_support, 
    StreamingTV AS streaming_tv, 
    Churn AS churn_status
FROM raw_churn_data;