install.packages("xlsx")
library(xlsx)

cybercrime <- read.xlsx("./data/cybercrime.xlsx", 1)  # read first sheet
head(cybercrime)