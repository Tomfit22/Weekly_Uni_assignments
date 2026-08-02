# load leaflet library
library(leaflet)

nz_map <- leaflet() %>%
  addTiles() %>%
  setView(lng = 171.7762, lat = -41.2865, zoom = 5)

nz_map


nz_pop <- data.frame(
  city = c("Auckland", "Wellington", "Christchurch"),
  lat = c(-36.8485, -41.2865, -43.5321),
  lng = c(174.7633, 174.7762, 172.6362),
  population = c(1657000, 215200, 381500)  # approx 2025 estimates
)

# Create NZ map with markers
nz_map_pop <- leaflet(nz_pop) %>%
  addTiles() %>%
  setView(lng = 174.7762, lat = -41.2865, zoom = 5) %>%
  addMarkers(~lng, ~lat, popup = ~paste(city, "<br>Population:", population))

nz_map_pop


#1