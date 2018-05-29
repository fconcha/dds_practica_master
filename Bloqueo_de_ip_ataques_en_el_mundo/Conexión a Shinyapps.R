install.packages("rsconnect")
library(rsconnect)
install.packages("shiny")

rsconnect::setAccountInfo(name='fconcha',
                          token='BB8CDCA6F643BB0BC1E351652CA29534',
                          secret='dhxBXC4BN3iKmpYnN95LTDBh3JZ/u3hZSdPEfdP2')

library(rsconnect)
rsconnect::deployApp('/Users/felipeconcha/ddspracticamaster/Bloqueo_de_ip_ataques_en_el_mundo')
