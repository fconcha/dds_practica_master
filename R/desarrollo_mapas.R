# Mapas 1
# Cargamos las librerias necesarias para trabajar con leaflet
install.packages("leaflet")
library(leaflet)
library(sp)

# Primero mostramos el mapa y luego seteamos las marcas de latitud y longitud que vienen desde nuestro objeto creado antes llamado
# ip_geo_merge y le damos un comentario por el tipo de ataque
world_map <- leaflet() %>% addTiles() %>% 
  addMarkers(data = ip_geo_merge, lng = ip_geo_merge$longitude, lat = ip_geo_merge$latitude, popup = ip_geo_merge$servicio, clusterOptions = markerClusterOptions())


# Mostramos el objeto

world_map



##mapas 2

install.packages("ggmap")
library(ggmap)
library(ggplot2)

asia_cont <- get_map("China", source = "google", zoom = 3, maptype = "terrain")

# Creamos un nuevo data frame (llamado df_coordenadas) de coordenadas que son extraidas desde el dataframe ip_geo_merge

lon <- ip_geo_merge$longitude
lat <- ip_geo_merge$latitude
df_coordenadas <- data.frame(lon, lat)

View(df_coordenadas)

# Mostramos el mapa y los puntos en donde se efectuan los ataques
ggmap(asia_cont) + geom_point(data = df_coordenadas, col="red", size = 1)

# MAPA 3 CON TODO EL MUNDO
devtools::install_github("dkahle/ggmap")

ggmap(get_stamenmap(bbox = c(left = -180, bottom = -80, right = 179.9999, top = 85), zoom = 3)) + geom_point(data = df_coordenadas, col="red", size = 0.1)


#MAPA 4
reclat=c(50,20,30,40)
reclong=c(30,40,30,50)         
points=as.data.frame(cbind(reclat,reclong))

al1 = get_map(location = 'Europe', zoom = 3, color="bw",maptype = "terrain")
map = ggmap(al1)
map 

#this works
map+geom_point(data=points, aes(x=reclong, y=reclat, colour="red"))

# MAPA 6
world <- map_data("world")
worldmap <- ggplot(world, aes(x=long, y=lat, group=group)) +
  geom_path() +
  scale_y_continuous(breaks=(-2:2) * 30) +
  scale_x_continuous(breaks=(-4:4) * 45)

#this works
worldmap + geom_point(aes(50, 30, colour="red"))





