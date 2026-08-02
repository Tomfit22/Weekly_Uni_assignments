library(dplyr)
library(nycflights13)

flights_clean <- flights %>%
  select(carrier, dep_delay, arr_delay) %>%
  left_join(airlines, by = "carrier") %>%
  select(name, dep_delay, arr_delay)

