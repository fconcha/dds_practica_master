# Funciones de carga de datos
loadBlock <- function(url, rows) {
  block <- read.csv(url)
  return(as.data.frame((block[sample(nrow(block), rows), ])))
}
