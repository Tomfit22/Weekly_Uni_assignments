# flights_clean_dt.R
# Load required packages
if (!requireNamespace("data.table", quietly = TRUE)) {
  install.packages("data.table")
}
library(data.table)
library(nycflights13)

flights_dt<- as.data.table(flights)
airlines_dt <- as.data.table(airlines)

flights_clean_dt <- flights_dt[, .(carrier, dep_delay, arr_delay)][
  airlines_dt, on = "carrier"
][, .(name, dep_delay, arr_delay)] 

delay_summary_dt <- flights_clean_dt[
  , .(
    avg_dep_delay = round(mean(dep_delay, na.rm = TRUE), 2),
    avg_arr_delay = round(mean(arr_delay, na.rm = TRUE), 2)
  ),
  by = name
][order(avg_dep_delay)]  # Sort from shortest to longest dep delay

print(delay_summary_dt)