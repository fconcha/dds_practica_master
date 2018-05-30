# Recommended code style https://google.github.io/styleguide/Rguide.xml
# Execute local tests from console using > testthat::test_dir("tests/testthat")
# Instalación de Paquetes base para la creación del data frame

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}
if (!require(rjson)) {
  install.packages("rjson")
  library(rjson)
}
if (!require(RCurl)) {
  install.packages("RCurl")
  library(RCurl)
}
if (!require(bitops)) {
  install.packages("bitops")
  library(bitops)
}

# Cargamos Shiny para ver los mapas en html
if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}

# Cargamos las librerias necesarias para trabajar con leaflet
if (!require(leaflet)) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require(sp)) {
  install.packages("sp")
  library(sp)
}

# Filtrado de datos
# if (!require(dplyr)) {
#   install.packages("dplyr")
#   library(dplyr)
# }

# Funciones de carga de datos
source("load_data.R")
# loadBlock <- function(url, rows) {
#   block <- read.csv(url)
#   return(as.data.frame((block[sample(nrow(block), rows), ])))
# }

# Rows to load
trows = 8

# Creación de un data frame que contiene la lista de todas las IP bloquedas proporcionadas por el sitio https://lists.blocklist.de/lists/all.txt
# divididas por una muestra aleatoria de 8 filas de cada unas de las amenzas registradas, ataques servidor apache, email, ftp, ssh, imap,
# sip (SIP-, VOIP- or Asterisk), fuerza bruta, además de todas las ip (no es una muestra de 8)trong que son las que han estado activas por
#mas de dos meses y contienen mas de 5000 ataques

# block_apache <- read.csv("https://lists.blocklist.de/lists/apache.txt")
# block_apache <- as.data.frame((block_apache[sample(nrow(block_apache), 8), ]))
block_apache <- loadBlock("https://lists.blocklist.de/lists/apache.txt", trows)

# block_email <- read.csv("https://lists.blocklist.de/lists/email.txt")
# block_email <- as.data.frame((block_email[sample(nrow(block_email), 8), ]))
block_email <- loadBlock("https://lists.blocklist.de/lists/email.txt", trows)

# block_ftp <- read.csv("https://lists.blocklist.de/lists/ftp.txt")
# block_ftp <- as.data.frame((block_ftp[sample(nrow(block_ftp), 8), ]))
block_ftp <- loadBlock("https://lists.blocklist.de/lists/ftp.txt", trows)

# block_ssh <- read.csv("https://lists.blocklist.de/lists/ssh.txt")
# block_ssh <- as.data.frame((block_ssh[sample(nrow(block_ssh), 8), ]))
block_ssh <- loadBlock("https://lists.blocklist.de/lists/ssh.txt", trows)

# block_imap <- read.csv("https://lists.blocklist.de/lists/imap.txt")
# block_imap <- as.data.frame((block_imap[sample(nrow(block_imap), 8), ]))
block_imap <- loadBlock("https://lists.blocklist.de/lists/imap.txt", trows)

# block_sip <- read.csv("https://lists.blocklist.de/lists/sip.txt")
# block_sip <- as.data.frame((block_sip[sample(nrow(block_sip), 8), ]))
block_sip <- loadBlock("https://lists.blocklist.de/lists/sip.txt", trows)

# block_brute <- read.csv("https://lists.blocklist.de/lists/bruteforcelogin.txt")
# block_brute <- as.data.frame((block_brute[sample(nrow(block_brute), 8), ]))
block_brute <- loadBlock("https://lists.blocklist.de/lists/bruteforcelogin.txt", trows)

block_strong <- read.csv("https://lists.blocklist.de/lists/strongips.txt")

# bajar fuentes dinamicamente:
# lista_dfs <- sapply(my_services, functoin(url){
#   response <- ?httpGET()
#   a <- read.csv(url)
#   as.data.frame()
# })

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
# View(ip_geo_strong)

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
# ip_geo_merge <- rbind.data.frame(ip_geo_apache, ip_geo_email, ip_geo_ftp, ip_geo_ssh, ip_geo_imap, ip_geo_sip, ip_geo_brute, ip_geo_strong)
ip_geo_merge <- rbind.data.frame(ip_geo_apache, ip_geo_email, ip_geo_ftp, ip_geo_imap, ip_geo_sip, ip_geo_brute, ip_geo_strong)

# Se muestra la tabla Final con los datos elegantes para poder mapear posteriormente.
# View(ip_geo_merge)

# Buscamos la data que tenemos en nuestro equipo que contiene el total de ataques 28135 lineas
# save(total_ataques, file = "R/total_ataques.rda")
# total_ataques <- read.csv("data/total_dataframe.txt", sep = "\t")
load("total_ataques.rda")

# Vemos el resultado de los datos obtenidos con shiny en dos vistas, la primera que contiene una muestra de los ataques los últimos 48 minutos
# La segunda que contiene el total de ataques de todos los servicios
# ui ----
ui <- fluidPage(
  # checkboxGroupInput("servicio", "Services to show:",
  #                    c("Apache" = "Apache",
  #                      "Email" = "Email",
  #                      "Ftp" = "Ftp",
  #                      "Ssh" = "Ssh",
  #                      "Imap" = "Imap",
  #                      "Sip" = "Sip",
  #                      "Brute" = "Brute",
  #                      "Strong" = "Strong"
  #                      ), selected = c("Apache")
  #                    ),
  tabsetPanel(
    tabPanel("Muestra Ataques 48 horas", verbatimTextOutput("summary"), leafletOutput(
      "mimapa", width = "100%", height = 910)
    ),
    tabPanel("Total de ataques", tableOutput("table"), leafletOutput(
      "world_map", width = "100%", height = 910)
    )
  ),
  absolutePanel(
    bottom = 50, right = 50, width = 200,
    draggable = TRUE)
)

# server ----
server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  # filteredData <- reactive({
  #   dplyr::filter(ip_geo_merge, servicio %in% input$servicio)
  # })
  # 
  # observe({
  #   output$mimapa <- renderLeaflet(
  #     leaflet() %>% addTiles() %>%
  #     addMarkers(data = filteredData, lng = filteredData$longitude, lat = filteredData$latitude, popup = filteredData$servicio, clusterOptions = markerClusterOptions())
  #   )
  # })
  
  output$mimapa <- renderLeaflet(
    leaflet() %>% addTiles() %>%
    addMarkers(data = ip_geo_merge, lng = ip_geo_merge$longitude, lat = ip_geo_merge$latitude, popup = ip_geo_merge$servicio, clusterOptions = markerClusterOptions())
  )

  output$world_map <-renderLeaflet(
    leaflet() %>% addTiles() %>%
    addMarkers(data = total_ataques, lng = total_ataques$longitude, lat = total_ataques$latitude, popup = total_ataques$time_zone, clusterOptions = markerClusterOptions())
  )}

shinyApp(ui, server, options = list(display.mode="showcase", launch.browser=T)
)
