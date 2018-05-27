library(shiny)

ui <- fluidPage(
  tabsetPanel(
    tabPanel("Muestra Ataques 48 horas", verbatimTextOutput("summary"), leafletOutput(
      "mimapa", width = "100%", height = 910)
    ), 
    tabPanel("Total de ataques", tableOutput("table"), leafletOutput(
      "world_map", width = "100%", height = 910) )
    ),
  
  absolutePanel(
    bottom = 50, right = 50, width = 200,
    draggable = TRUE)
  )
 

server <- function(input, output, session) {
  output$mimapa <- renderLeaflet(leaflet() %>% addTiles() %>% 
                                   addMarkers(data = ip_geo_merge, lng = ip_geo_merge$longitude, lat = ip_geo_merge$latitude, popup = ip_geo_merge$servicio, clusterOptions = markerClusterOptions())
  )
  output$world_map <-renderLeaflet( leaflet() %>% addTiles() %>% 
    addMarkers(data = total_ataques, lng = total_ataques$longitude, lat = total_ataques$latitude, popup = total_ataques$time_zone, clusterOptions = markerClusterOptions())
  )
}

shinyApp(ui, server)


