Spreadsheet Cleaning and Business Logic


Steps Performed


1. Cleaned merchant names using TRIM and PROPER.
2. Standardized transaction status into SUCCESS, FAILED, CHARGEBACK.
3. Extracted numeric risk scores using REGEX.
4. Standardized region values using UPPER.
5. Converted all amounts into USD using exchange rates based on date and currency.
6. Created high_value_flag based on region thresholds.
7. Created high_risk_flag based on risk score and chargebacks.
8. Generated merchant-level summary using pivot table.


Output Files


- cleaned_transactions.csv
- merchant_risk_summary.csv