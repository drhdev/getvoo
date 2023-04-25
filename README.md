# getvoo - Daily VOO ETF Price Updater

This Bash script retrieves the daily closing price of the VOO ETF from the Alpha Vantage API and stores the price in a SQLite database. The script is designed to be run daily using a cron job.

## Requirements

- Bash
- curl
- jq
- SQLite 3

## Setup

1. Get an API key from [Alpha Vantage](https://www.alphavantage.co/support/#api-key).
2. Clone or download this repository to your local machine.
3. Set the `API_KEY` variable in the script to your Alpha Vantage API key.
4. Set the `SYMBOL` variable to the symbol of the ETF you want to track. The default symbol is "VOO".
5. Open the terminal and navigate to the directory where you cloned or downloaded the repository.
6. Run the following command to make the script executable: chmod +x daily_voo_price_updater.sh
7. Add a cron job to run the script daily. For example, to run the script every day at 9:00 AM, open the crontab editor by running the following command: crontab -e
8. Add the following line to the crontab file: 0 9 * * * /path/to/daily_voo_price_updater.sh
Replace "/path/to/" with the path to the directory where you cloned or downloaded the repository. This line runs the script every day at 9:00 AM.

## Usage

When the script runs, it retrieves the previous closing price of the VOO ETF from the SQLite database. It then calls the Alpha Vantage API to get the latest closing price of the VOO ETF. If the API returns a price for the current date, the script checks if the new price is different from the previous price. If the new price is the same as the previous price, the script writes "unchanged" to the SQLite database. Otherwise, the script writes the new price to the database.

The script creates a new SQLite database file named "database.sqlite" in the same directory as the script if the file does not exist. The database file contains a single table named "voo_prices" that stores the date, time, and price of the VOO ETF.

To view the contents of the "voo_prices" table, you can use the following command: sqlite3 database.sqlite "SELECT * FROM voo_prices;"


## License

This project is licensed under the [GPLv3](LICENSE).

