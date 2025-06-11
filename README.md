# 16-Day-Weather-Forecast-Script
This R script fetches historical (1-day) and 16-day weather forecasts for customizable locations using the Open-Meteo API. It compiles daily summaries (e.g., max/min temperature, precipitation, wind speed) and computes Heating and Cooling Degree Days. Results are saved to an Excel workbook with separate sheets for historical and forecast data.


README.md

Project Title

16-Day Weather Forecast Script

Description

This R script fetches historical (1-day) and 16-day weather forecasts for customizable locations using the Open-Meteo API. It compiles daily summaries (e.g., max/min temperature, precipitation, wind speed) and computes Heating and Cooling Degree Days. Results are saved to an Excel workbook with separate sheets for historical and forecast data.

Key Features

Fetches historical data for the previous day

Retrieves 16-day forecast for specified locations

Computes average temperature, Heating Degree Days (HDDs), and Cooling Degree Days (CDDs)

Exports results to an Excel file with two sheets: Historical and Forecast

Configurable units (°F, mph, inches)

Proxy support for corporate network environments

Prerequisites

R (version >= 4.0)

Internet connection

Access to Open-Meteo API (no API key required)

Dependencies

install.packages(c("httr", "jsonlite", "openxlsx"))

Configuration

Proxy (if needed):

set_config(use_proxy("Proxy URL Placeholder", port = "Port # Placeholder"))

Locations: Define named coordinates in the locations list:

locations <- list(
  "Atlanta, GA" = c(33.749, -84.388),
  "New York, NY" = c(40.7128, -74.0060)
)

Units & Variables:

daily_vars: comma-separated variables

temperature_unit: "fahrenheit" or "celsius"

wind_speed_unit: "mph" or "kmh"

precipitation_unit: "inch" or "mm"

timezone: e.g., "America/New_York"

Usage

Open the script in RStudio or your preferred IDE.

Update proxy settings (if necessary).

Modify the locations list with your desired cities.

Run the script:

source("weather_forecast.R")

Check the output Excel file at the specified local_path.

Output

Historical sheet: previous day’s metrics

Forecast sheet: next 16 days’ metrics, including HDDs and CDDs

Customization

Adjust start_date and end_date for multi-day historical data

Change forecast_days parameter in the forecast URL

Add or remove variables in daily_vars

Contributing

Fork the repo

Create a new branch: git checkout -b feature/my-new-feature

Commit changes: git commit -am 'Add new feature'

Push: git push origin feature/my-new-feature

Submit a Pull Request
