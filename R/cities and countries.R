
read_table6 <- head(read.csv("https://lists.blocklist.de/lists/all.txt"), 40)
rangodeip <- head(read.csv("/Users/felipeconcha/Downloads/dbip-city-2018-05.csv"), 40)
class(rangodeip)
rangodeip
install.packages('devtools')
library(devtools)
install_github('freegeoip', 'luiscape')
test1 <- data.frame('1.1.217.5')
test1
read_table6
class(read_table6)
dim(read_table4)
test2 <- freegeoip(test1)
class(test2)
View(test2)
geolocalizacion <- freegeoip(read_table6)
View(geolocalizacion)
View(read_table6)

install.packages("ggmap")
library(ggmap)
map_atlanta <- get_map("atlanta", zoom = 10)
ggmap(map_atlanta)
map_coordenadas <- get_map(location = c(lon = geolocalizacion$longitude, lat = geolocalizacion$latitude), zoom = "auto")
ggmap(map_coordenadas)
map_brasil <- get_map(location= "China", source="google", maptype="terrain", zoom=3)
map_mundo <- get_map(location = "India", zoom = 10, scale = 2)
ggmap(map_mundo)
map_brasil
ggmap(map_brasil)
coordenadas <- data.frame(geolocalizacion2$longitude,geolocalizacion2$latitude)
coordenadas
colnames(coordenadas) <- c("lon", "lat")
coordenadas
class(coordenadas)
library(ggplot2)
ggmap(map_brasil) + geom_point(data = coordenadas, color = "red", size = 1)
?geom_point
?get_map
mapaprueba <- get_map(location = "all the World", zoom = 10)
ggmap(mapaprueba)

test1función <- function(df = NULL) {

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

geolocalizacion2 <- test1función(read_table6)
View(geolocalizacion2)

class(segunda_tabla$fELIPE)

read_table4[1:11,]
colnames(read_table4) <- c("fELIPE")

read_table1
read_table4

names(read_table4) <-

dim(read_table4)


class(read_table4)
str(segunda_tabla)

object.size(read_table4)
cuarenta_filas <- head(read_table4, 40)
class(cuarenta_filas)
segunda_col <- c(1:40)
class(segunda_col)

segunda_tabla <- data.frame(cuarenta_filas,segunda_col)
segunda_tabla
class(segunda_tabla$segunda_col)
class(segunda_tabla$tercera_col)

id_nombre <- c(1, 3, 9, 10, 11)
id_nombre
nombre_id <- c("felipe", "andres", "concha", "sepulveda", "alan")
nombre_id

tercera_tabla <- data.frame(id_nombre, nombre_id)
tercera_tabla
class(rangodeip$ciudad2)
View(tercera_tabla)
View(rangodeip)
match(segunda_tabla$segunda_col, tercera_tabla$id_nombre)
tercera_tabla$nombre_id[match(segunda_tabla$segunda_col, tercera_tabla$id_nombre)]
segunda_tabla$tercera_col <- tercera_tabla$nombre_id[match(segunda_tabla$segunda_col, tercera_tabla$id_nombre)]

x <- 1:5
x
class(x)
dim(x)
names(x) <- c("a", "b", "c", "d", "e")
x[2]
rownames(rangodeip)
colnames(rangodeip) <- c("inicio", "final", "pais", "ciudad1", "ciudad2")
colnames(read_table5)

veinte_filas <- read_table5 [1:20, ]
veinte_filas

class(veinte_filas)

y <- matrix(1:20, 4, 5)
y
class(y)
dim(y)
names(y) <- c("a", "b", "c", "d", "e")
rownames(y) <- c("fila1", "fila2", "fila3", "fila4")
colnames(y) <- c("col_A", "col_B", "col_C", "col_D", "col_E")
propios <- eigen(y[,1:4])
propios
class(propios)
class(propios$values)
class(propios$vectors)
names(propios$values) <- 1:4
names(propios) <- c("valores","vectores")
colnames(propios$vectores) <- c("vector_1","vector_2","vector_3","vector_4")
z <- as.data.frame(y)
z
class(z)
rownames(z) <- c("obs_1","obs_2","obs_3","obs_4")
colnames(z) <- c("var_A","var_B","var_C","var_D","var_E")

peso <- c(50,70,45,80,72)
altura <- c(160,165,180,190,175)
edad <- c(20,40,41,31,33)
nombres <- c("Lorena","Manolo","Carmen","Luis","Sara")
sexo <- c("M","H","M","H","M")
datos <- data.frame(nombres,sexo,peso,altura,edad)
datos
colnames(datos)
row.names(datos)

pruebaf <- data.frame(read_table4, nombres)
nombres
colnames(datos) <- c("nombre", "sex")
datos
