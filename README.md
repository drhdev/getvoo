#What does the script do?
This Bash script retrieves the daily closing price of the VOO ETF from the Alpha Vantage API and stores the price in a SQLite database. The script is designed to be run daily using a cron job.

#Requirements
Bash
curl
jq
SQLite 3
Setup
Get an API key from Alpha Vantage.
Clone or download this repository to your local machine.
Set the API_KEY variable in the script to your Alpha Vantage API key.
