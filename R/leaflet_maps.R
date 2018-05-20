install.packages("leaflet")
library(leaflet)
library(sp)

data_sp <- SpatialPointsDataFrame(geolocalizacion2[,c(10, 11)]), data[]

mapa_lea <- leaflet() %>% addTiles()
mapa_lea


