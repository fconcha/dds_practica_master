# dds_practica_master
# Muestra de una forma gráfica en un mapa mundi, el lugar de donde provienen los ataques mas frecuentes que han sido detectados
# por diferentes servidores, es decir muestra las IP bloqueadas.
# La fuente de información es un servicio de reportes que actualiza su información cada 30 minutos y que contiene
# Información de las últimas 48 hrs. http://www.blocklist.de/en/export.html
# Esta aplicación en R busca a través de una función una muestra de 8 registros por cada servicio disponible en la página
# http://www.blocklist.de/en/export.html y muestra un mapa para tener una referencia de lo que pasa actualmente.
# También muestra un segundo mapa que contiene el registro completo de todas las ip que muestra la 
# página http://www.blocklist.de/en/export.html en las últimas 48 hrs (esta parte no está en línea) para tener una idea
# general de los ataques y respectivos bloqueos de esas IP.



