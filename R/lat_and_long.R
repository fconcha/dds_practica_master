# Instalación de Paquetes base para la creación del data frame

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
# divididas por una muestra aleatoria de 80 filas de cada unas de las amenzas registradas, ataques servidor apache, email, ftp, ssh, imap,
# sip (SIP-, VOIP- or Asterisk), fuerza bruta, además de todas las ip (no es una muestra de 80)trong que son las que han estado activas por
#mas de dos meses y contienen mas de 5000 ataques
block_apache <- read.csv("https://lists.blocklist.de/lists/apache.txt")
block_apache <- as.data.frame((block_apache[sample(nrow(block_apache), 80), ]))
block_email <- read.csv("https://lists.blocklist.de/lists/email.txt")
block_email <- as.data.frame((block_email[sample(nrow(block_email), 80), ]))
block_ftp <- read.csv("https://lists.blocklist.de/lists/ftp.txt")
block_ftp <- as.data.frame((block_ftp[sample(nrow(block_ftp), 80), ]))
block_ssh <- read.csv("https://lists.blocklist.de/lists/ssh.txt")
block_ssh <- as.data.frame((block_ssh[sample(nrow(block_ssh), 80), ]))
block_imap <- read.csv("https://lists.blocklist.de/lists/imap.txt")
block_imap <- as.data.frame((block_imap[sample(nrow(block_imap), 80), ]))
block_sip <- read.csv("https://lists.blocklist.de/lists/sip.txt")
block_sip <- as.data.frame((block_sip[sample(nrow(block_sip), 80), ]))
block_brute <- read.csv("https://lists.blocklist.de/lists/bruteforcelogin.txt")
block_brute <- as.data.frame((block_brute[sample(nrow(block_brute), 80), ]))
block_strong <- read.csv("https://lists.blocklist.de/lists/strongips.txt")


# Seteamos el título de nuestra primera columna del dataframe con el nombre de "IP" de cada objeto creado antes

colnames(block_apache) <- c("IP")
colnames(block_email) <- c("IP")
colnames(block_ftp) <- c("IP")
colnames(block_ssh) <- c("IP")
colnames(block_imap) <- c("IP")
colnames(block_sip) <- c("IP")
colnames(block_brute) <- c("IP")
colnames(block_strong) <- c("IP")

# Creamos una función (Esta función es una reurilización de código Descargado de un PKG proporcionado en el GitHub de Luis Cape que se puede
# Instalar de la siguiente forma install_github('freegeoip', 'luiscape')), en este caso estamos reutilizando la única función del PKG que
# debe recibir siempre como argumento un dataframe, en este caso los que se crearon en el paso anterior (block_apache,block_email,
# block_ftp, block_ssh, block_imap, block_sip, block_brute, block_strong  )

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

# Utilizamos la función para geolocalizar las ip de nuestros objetos creados anteriormente y las asignamos a uno nuevo
#Este paso es el mas lento porque busca cada registro del objeto en la api proporcinada en la función.

ip_geo_apache <- geodeip(block_apache)
ip_geo_email <- geodeip(block_email)
ip_geo_ftp <- geodeip(block_ftp)
ip_geo_ssh <- geodeip(block_ssh)
ip_geo_imap <- geodeip(block_imap)
ip_geo_sip <- geodeip(block_sip)
ip_geo_brute <- geodeip(block_brute)
ip_geo_strong <- geodeip(block_strong)

# Vemos los resultados del objeto con una vista de tabla ejemplo Strong

View(ip_geo_strong)

# Agreamos una columna a cada objeto con el nombre del servicio atacado

ip_geo_apache$servicio <- rep("Apache", length(ip_geo_apache$ip))
ip_geo_email$servicio <- rep("Email", length(ip_geo_email$ip))
ip_geo_ftp$servicio <- rep("Ftp", length(ip_geo_ftp$ip))
ip_geo_ssh$servicio <- rep("Ssh", length(ip_geo_ssh$ip))
ip_geo_imap$servicio <- rep("Imap", length(ip_geo_imap$ip))
ip_geo_sip$servicio <- rep("Sip", length(ip_geo_sip$ip))
ip_geo_brute$servicio <- rep("Brute", length(ip_geo_brute$ip))
ip_geo_strong$servicio <- rep("Strong", length(ip_geo_strong$ip))


# Hacemos una unión de todas los objetos (en esta caso tablas que tienen el mismo formato, por lo tanto se puede utilizar la función
# rbind.data.frame)
ip_geo_merge <- rbind.data.frame(ip_geo_apache, ip_geo_email, ip_geo_ftp, ip_geo_ssh, ip_geo_imap, ip_geo_sip, ip_geo_brute, ip_geo_strong)


# Se muestra la tabla Final con los datos elegantes para poder mapear posteriormente.
View(ip_geo_merge)





