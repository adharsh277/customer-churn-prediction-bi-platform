-- Schema for customer churn dataset
-- Example table definitions
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    signup_date DATE,
    churned BOOLEAN,
    churn_date DATE
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    plan VARCHAR(50),
    monthly_fee NUMERIC(8,2),
    start_date DATE,
    end_date DATE
);
