write.table(total_p24000, file = "total_p24000.txt", sep = "\t", row.names = FALSE)
ip_geo_txt <- read.csv("/Users/felipeconcha/ddspracticamaster/merge_muestra1.txt", sep = "\t")

total_ip <- read.csv("https://lists.blocklist.de/lists/all.txt")
colnames(total_ip) <- c("IP")
colnames(total_ip)

library(devtools)
library(rjson)
library(RCurl)
library(bitops)

primeras_24000 <- as.data.frame(total_ip$IP[16001:24000])
primeras_8000

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

total_p24000 <- geodeip(primeras_24000)
total_p8000
total_p16000
total_p24000
ls ()

a <- c(1, 3, 4, 5, 3, 5, 6)
a[4:8]
