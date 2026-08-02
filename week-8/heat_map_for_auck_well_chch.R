library(leaflet)

# NZ dataset
nz_pop <- data.frame(
  city = c("Auckland", "Wellington", "Christchurch"),
  lat = c(-36.8485, -41.2865, -43.5321),
  lng = c(174.7633, 174.7762, 172.6362),
  population = c(1657000, 215200, 381500)
)

# Color palette (log scale so Auckland doesn't dominate)
pal <- colorNumeric("viridis", domain = log10(nz_pop$population))

# Create circle-based "heatmap" style
nz_circles <- leaflet(nz_pop) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = 174.7762, lat = -41.2865, zoom = 5) %>%
  addCircles(
    lng = ~lng, lat = ~lat,
    weight = 1,           # fixed stroke width
    radius = 20000,       # fixed radius (in meters)
    color = ~pal(log10(population)),
    fillOpacity = 0.8,
    popup = ~paste0(city, ": ", formatC(population, big.mark = ","))
  ) %>%
  addLegend(
    pal = pal,
    values = ~log10(population),
    opacity = 1.0,
    labFormat = labelFormat(transform = function(x) round(10^x)),
    title = "Population"
  )


nz_circles

#1
