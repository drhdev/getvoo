#!/bin/bash

# Set your Alpha Vantage API key here
API_KEY="your_api_key_here"

# Set the VOO ETF symbol
SYMBOL="VOO"

# Set the path to the directory where the script and database file are located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set the path to the SQLite database file
DB_FILE="$SCRIPT_DIR/database.sqlite"

# Check if the database file exists
if [ ! -f "$DB_FILE" ]; then
  # Create the database file and the voo_prices table
  sqlite3 $DB_FILE "CREATE TABLE voo_prices (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, price REAL);"
fi

# Get the previous VOO price from the database
PREVIOUS_PRICE=$(sqlite3 $DB_FILE "SELECT price FROM voo_prices ORDER BY id DESC LIMIT 1;")

# Get the current date and time
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Call the Alpha Vantage API to get the latest closing price of VOO
PRICE=$(curl -s "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=$SYMBOL&apikey=$API_KEY" | jq -r '.["Time Series (Daily)"] | keys_unsorted[] as $k | select($k | startswith("'"$(date +%Y-%m-%d)"'")) | .[$k]."4. close"')

# Check if the price is not empty
if [ -n "$PRICE" ]; then
  # Check if the current price is the same as the previous price
  if [ "$PRICE" = "$PREVIOUS_PRICE" ]; then
    # Write "unchanged" to the database instead of the new price
    sqlite3 $DB_FILE "INSERT INTO voo_prices (date, price) VALUES ('$DATE', 'unchanged');"
  else
    # Insert the date, time, and price into the database
    sqlite3 $DB_FILE "INSERT INTO voo_prices (date, price) VALUES ('$DATE', $PRICE);"
  fi
fi
