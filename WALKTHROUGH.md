WALKTHROUGH.md

Overview

This walkthrough guides you through setting up and running the 16-Day Weather Forecast Script.

1. Clone the Repository

git clone https://github.com/<your-username>/weather-forecast-16day.git
cd weather-forecast-16day

2. Install Dependencies

Open R and run:

install.packages(c("httr", "jsonlite", "openxlsx"))

3. Configure the Script

Proxy: Update use_proxy() if behind a corporate firewall.

Locations: Edit the locations list in weather_forecast.R.

Units: Verify that the units match your preference.

4. Run the Script

In RStudio: click Source

Or in R console:

source("weather_forecast.R")

5. Review Output

Navigate to the local path (e.g., C:/Temp/Weatherapi_data.xlsx).

Open the file to inspect Historical and Forecast sheets.

6. Customize Further

To fetch more historical days, set start_date <- Sys.Date() - n

To change forecast range, modify &forecast_days=16 in the URL.
