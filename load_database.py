import pandas as pd
import sqlite3

# Load dataset
df = pd.read_csv("data/credit_card_fraud_10k.csv")

# Connect to SQLite database
connection = sqlite3.connect("fraud_analytics.db")

# Load data into SQLite
df.to_sql(
    "transactions",
    connection,
    if_exists="replace",
    index=False
)

connection.close()

print("Database created successfully!")
print("Table: transactions")
print(f"Rows loaded: {len(df)}")