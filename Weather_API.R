# If needed, install packages:

# install.packages(c("httr", "jsonlite", "openxlsx"))

 

library(httr)

library(jsonlite)

library(openxlsx)

 

# Set the proxy configuration (no username/password example)

set_config(use_proxy("Proxy URL PLace Holder", port = "Port # PLaceholder")) 

 

# Define locations in a list of named coordinates

locations <- list(

Example Location - Atlanta, Ga = c(33.749, -84.388) 



)

 

# Common parameters

start_date <- Sys.Date() - 1

 

 

end_date <- Sys.Date()

daily_vars <- "temperature_2m_max,temperature_2m_min,precipitation_sum,rain_sum,precipitation_hours,wind_speed_10m_max"

temperature_unit <- "fahrenheit"

wind_speed_unit <- "mph"

precipitation_unit <- "inch"

timezone <- "America/New_York"

 

# Initialize lists to store data frames

all_historical_results <- list()

all_forecast_results <- list()

 

for (loc_name in names(locations)) {

  coords <- locations[[loc_name]]

  lat <- coords[1]

  lon <- coords[2]

 

  # Construct URL for historical data

  hist_url <- paste0(

    https://historical-forecast-api.open-meteo.com/v1/forecast?,

    "latitude=", lat,

    "&longitude=", lon,

    "&start_date=", start_date,

    "&end_date=", end_date,

    "&daily=", daily_vars,

    "&temperature_unit=", temperature_unit,

    "&wind_speed_unit=", wind_speed_unit,

    "&precipitation_unit=", precipitation_unit,

    "&timezone=", URLencode(timezone)

  )

 

  # Fetch historical data using the proxy

  hist_res <- GET(hist_url)

  stop_for_status(hist_res)

  hist_data <- content(hist_res, as = "text", encoding = "UTF-8")

  hist_json_data <- fromJSON(hist_data)

 

  # Extract historical daily data

  hist_dates <- as.Date(hist_json_data$daily$time)

  hist_temp_max <- hist_json_data$daily$temperature_2m_max

  hist_temp_min <- hist_json_data$daily$temperature_2m_min

  hist_avg_temp <- (hist_temp_max + hist_temp_min) / 2

  hist_HDDs <- ifelse(hist_avg_temp < 65, 65 - hist_avg_temp, 0)

 

  hist_df <- data.frame(

    date = hist_dates,

    location = loc_name,

    temperature_2m_max = hist_temp_max,

    temperature_2m_min = hist_temp_min,

    precipitation_sum = hist_json_data$daily$precipitation_sum,

    rain_sum = hist_json_data$daily$rain_sum,

    precipitation_hours = hist_json_data$daily$precipitation_hours,

    wind_speed_10m_max = hist_json_data$daily$wind_speed_10m_max,

    HDDs = hist_HDDs,

    stringsAsFactors = FALSE

  )

 

  all_historical_results[[loc_name]] <- hist_df

 

  # Construct URL for forecast (14 days)

  forecast_url <- paste0(

    https://api.open-meteo.com/v1/forecast?,

    "latitude=", lat,

    "&longitude=", lon,

    "&daily=", daily_vars,

    "&temperature_unit=", temperature_unit,

    "&wind_speed_unit=", wind_speed_unit,

    "&precipitation_unit=", precipitation_unit,

    "&timezone=", URLencode(timezone),

    "&forecast_days=16"

  )

 

  # Fetch forecast data using the proxy

  fc_res <- GET(forecast_url)

  stop_for_status(fc_res)

  fc_data <- content(fc_res, as = "text", encoding = "UTF-8")

  fc_json_data <- fromJSON(fc_data)

 

  # Extract forecast daily data

  fc_dates <- as.Date(fc_json_data$daily$time)

  fc_temp_max <- fc_json_data$daily$temperature_2m_max

  fc_temp_min <- fc_json_data$daily$temperature_2m_min

  fc_avg_temp <- (fc_temp_max + fc_temp_min) / 2

  fc_HDDs <- ifelse(fc_avg_temp < 65, 65 - fc_avg_temp, 0)

  fc_CDDS <- ifelse(fc_avg_temp > 65, fc_avg_temp- 65, 0)

 

  fc_df <- data.frame(

    date = fc_dates,

    location = loc_name,

    Latititude= lat,

    Longitude = lon,

    temperature_2m_max = fc_temp_max,

    temperature_2m_min = fc_temp_min,

    precipitation_sum = fc_json_data$daily$precipitation_sum,

    rain_sum = fc_json_data$daily$rain_sum,

    precipitation_hours = fc_json_data$daily$precipitation_hours,

    wind_speed_10m_max = fc_json_data$daily$wind_speed_10m_max,

    HDDs = fc_HDDs,

    CDDs = fc_CDDS,

    stringsAsFactors = FALSE

  )

 

  all_forecast_results[[loc_name]] <- fc_df

}

 

# Combine all historical and forecast data into single data frames

final_historical_df <- do.call(rbind, all_historical_results)

final_forecast_df <- do.call(rbind, all_forecast_results)

 

# Create an Excel workbook and add two sheets

wb <- createWorkbook()

 

addWorksheet(wb, "Historical")

writeData(wb, "Historical", final_historical_df)

 

addWorksheet(wb, "Forecast")

writeData(wb, "Forecast", final_forecast_df)

 

# Save the workbook locally first

local_path <- "C:/Temp/Weatherapi_data.xlsx"  # Adjust to a local non-synced path

saveWorkbook(wb, local_path, overwrite = TRUE)

 

# Verify and copy to OneDrive/SharePoint

if (file.exists(local_path)) {

  cat("File saved locally successfully at:", local_path, "\n")

  # Test loading the file

  test_wb <- loadWorkbook(local_path)

  cat("Excel file validated successfully.\n")

  # Copy to final destination

  final_path <- "Path desitination to your file location" 

  file.copy(local_path, final_path, overwrite = TRUE)

  cat("File copied to OneDrive successfully at:", final_path, "\n")

} else {

  stop("Failed to save the Excel file locally.")

}
