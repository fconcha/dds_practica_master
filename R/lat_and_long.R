# Instalación de librerias base para la creación del data frame
install.packages('devtools')
install.packages("rjson")
install.packages("RCurl")
install.packages("bitops")


# Instalación de librerarias necesarios para la función que recorre la lista de IP

library(devtools)
library(rjson)
library(RCurl)
library(bitops)


# Creación de un data frame que contiene la lista de todas las IP bloquedas proporcionadas por el sitio https://lists.blocklist.de/lists/all.txt

block_list <- head(read.csv("https://lists.blocklist.de/lists/apache.txt"), 80)

# Seteamos el título de nuestra primera columna del dataframe

colnames(block_list) <- c("IP")

# Creamos una función (Esta función es una reurilización de código Descargado de un PKG proporcionado en el GitHub de Luis Cape que se puede 
# Instalar de la siguiente forma install_github('freegeoip', 'luiscape')), en este caso estamos reutilizando la única función del PKG que 
# debe recibir siempre como argumento un dataframe, en este caso el creado anteriormenete llamado block_list

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

# Utilizamos la función para geolocalizar las ip de nuestro objeto acreado anteriormente blocklist y las asignamos a un objeto llamado ipgeolocaización
ipgeolocalizacion <- geodeip(block_list)

# Vemos los resultados del objeto con una vista de tabla
View(ipgeolocalizacion)



                               