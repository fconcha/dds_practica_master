library(leaflet)

m <- leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18))

m <- addTiles(m)  # Add default OpenStreetMap map tiles
  #addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")

samps <- read.csv("./R/FieldSamples.csv")   #my data for sampling sites, contains a column of "lat" and a column of "lon" with GPS points in decimal degrees
m <- addMarkers(m, lng=samps$lon, lat=samps$lat)

m  # Print the map
