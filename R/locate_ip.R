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
