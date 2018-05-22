
# Buscamos la data que tenemos en nuestro equipo que contiene el total de ataques 28135 lineas
total_ataques <- read.csv("/Users/felipeconcha/ddspracticamaster/total_dataframe.txt", sep = "\t")

# Cargamos las librerias necesarias para trabajar con leaflet
install.packages("leaflet")
library(leaflet)
library(sp)

# Primero mostramos el mapa y luego seteamos las marcas de latitud y longitud que vienen desde nuestro objeto creado antes llamado
# ip_geo_merge y le damos un comentario por el tipo de ataque
world_map <- leaflet() %>% addTiles() %>% 
  addMarkers(data = total_ataques, lng = total_ataques$longitude, lat = total_ataques$latitude, popup = total_ataques$time_zone, clusterOptions = markerClusterOptions())

# Mostramos el objeto

world_map

####################################################################################################
test34
# unimos todos los dataframe creados en uno solo

total_dataframe <- rbind.data.frame(total_p8000, total_p16000, total_p24000, total_p28135)
total_dataframe
class(total_dataframe)

View(total_p24000)


total_ip <- read.csv("https://lists.blocklist.de/lists/all.txt")
colnames(total_ip) <- c("IP")
colnames(total_ip)

library(devtools)
library(rjson)
library(RCurl)
library(bitops)

primeras_28135 <- as.data.frame(total_ip$IP[24001:28135])

total_p28135

geodeip <- function(df = NULL) {
  if (is.data.frame(df) == FALSE) {
    warning('This function only works with data.frames. Please provide a data.frame.')
  }
  else {
    final <- data.frame()
    for (i in 1:nrow(df)) {
      url <- paste("http://freegeoip.net/json/", c(as.character(df[i,])), sep="")
      line <- tryCatch(
        data.frame(fromJSON(getURLContent(url))),
        error = function(e) e
      )
      if(inherits(line, "error")) line <- c(NA)
      final <- rbind(final, line)
    }
    return(final)
  }
}

total_p28135 <- geodeip(primeras_28135)
total_p8000
total_p16000
total_p24000
ls ()

a <- c(1, 3, 4, 5, 3, 5, 6)
a[4:8]
