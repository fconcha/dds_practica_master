library(shiny)

ui <- fluidPage(
  h5("este es mi título"),
  leafletOutput(
    "mimapa", height = "600")
)

server <- function(input, output, session) {
  output$mimapa <- renderLeaflet(leaflet() %>% addTiles() %>% 
                                   addMarkers(data = ip_geo_merge, lng = ip_geo_merge$longitude, lat = ip_geo_merge$latitude, popup = ip_geo_merge$servicio, clusterOptions = markerClusterOptions())
  )
}

shinyApp(ui, server)