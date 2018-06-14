#' Read a number of rows from the file specified in a URL.
#' 
#' @param url The file URL to read data from.
#' @param y A number.
#' @return A dataframe.
#' @examples
#' loadBlock("https://lists.blocklist.de/lists/apache.txt", 8)
loadBlock <- function(url, rows) {
  block <- read.csv(url)
  return(as.data.frame((block[sample(nrow(block), rows), ])))
}
