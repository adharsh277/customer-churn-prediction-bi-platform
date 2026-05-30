-- Import data for Telco Customer Churn CSV
-- Use psql client-side \copy to read file from this workspace
-- The NULL '' option treats empty strings as NULL (useful for TotalCharges blanks)
\copy customers(customer_id, gender, SeniorCitizen, Partner, Dependents, tenure, PhoneService, MultipleLines, InternetService, OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalCharges, Churn)
FROM '/workspaces/customer-churn-prediction-bi-platform/data/raw/WA_Fn-UseC_-Telco-Customer-Churn[1].csv'
DELIMITER ',' CSV HEADER NULL '';

-- Note: Run this from a psql client (not inside server) or adjust to server-side COPY if the file is accessible to the DB server.
