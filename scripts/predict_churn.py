import pandas as pd
from pathlib import Path

import joblib
from sklearn.preprocessing import LabelEncoder


Path("../data/processed").mkdir(parents=True, exist_ok=True)


def preprocess_data(dataframe: pd.DataFrame) -> pd.DataFrame:
    dataframe = dataframe.copy()

    dataframe["TotalCharges"] = pd.to_numeric(
        dataframe["TotalCharges"],
        errors="coerce"
    )

    dataframe["TotalCharges"] = dataframe["TotalCharges"].fillna(
        dataframe["TotalCharges"].median()
    )

    for col in dataframe.select_dtypes(include=["object", "string"]).columns:
        if col != "customerID":
            le = LabelEncoder()
            dataframe[col] = le.fit_transform(dataframe[col])

    return dataframe


df = pd.read_csv("../data/raw/WA_Fn-UseC_-Telco-Customer-Churn[1].csv")
model = joblib.load("../models/random_forest.pkl")

customer_ids = df["customerID"].copy()
features = preprocess_data(df).drop(columns=["customerID", "Churn"])

churn_probability = model.predict_proba(features)[:, 1]

predictions = pd.DataFrame({
    "customerID": customer_ids,
    "churn_probability": churn_probability,
})


def risk_category(probability: float) -> str:
    if probability >= 0.75:
        return "High"
    if probability >= 0.40:
        return "Medium"
    return "Low"


predictions["risk_category"] = predictions["churn_probability"].apply(risk_category)
predictions["churn_probability"] = predictions["churn_probability"].round(4)

predictions.to_csv("../data/processed/predictions.csv", index=False)

print(predictions.head())
print("\nSaved predictions to ../data/processed/predictions.csv")
