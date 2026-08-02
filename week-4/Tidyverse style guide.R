head(flights) 
flight_delays <- flights %>%
  select(carrier, dep_delay, arr_delay)
airlines
flights

head(flight_delays)

flights_clean <- flights %>%
  select(carrier, dep_delay, arr_delay) %>%
  left_join(airlines, by = "carrier") %>%
  select(name, dep_delay, arr_delay)  

head(flights_clean)s