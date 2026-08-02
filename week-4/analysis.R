# Run the cleaning script
source("flights_clean.R")


head(flights_clean)


delay_summary <- flights_clean %>%
  group_by(name) %>%
  summarise(
    avg_dep_delay = round(mean(dep_delay, na.rm = TRUE), 2),
    avg_arr_delay = round(mean(arr_delay, na.rm = TRUE), 2)
  ) %>%
  arrange(avg_dep_delay)

print(delay_summary)
