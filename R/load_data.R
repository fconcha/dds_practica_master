install.packages("xlsx")
library(xlsx)

LoadData <- function(file.name) {
  d <- read.xlsx(file.name, 1)  # read first sheet
  return(d)
}

ShowSomeData <- function(d) {
  head(d)
}

dataset <- LoadData("./data/cybercrime.xlsx")
ShowSomeData(dataset)