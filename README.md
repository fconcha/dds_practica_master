1.- Definir nuestra pregunta:
Lo primero que hemos hecho en la construcción de esta solución ha sido definir nuestra pregunta:
¿Cómo se distribuyen geográficamente los ataques informáticos producidos en el mundo en las últimas 48 horas?
A partir de esto hemos desarrollado los siguientes pasos.

2.- Definir el conjunto de datos ideal:
Con la pregunta ya definida hemos buscado en distintas fuentes la información necesaria para responder a nuestra pregunta, la característica principal de los datos buscados es que debía ser una fuente actualizada frecuentemente para tener una muestra de los ataques en tiempo real.
Con esta información en la mente encontramos una fuente que muestra todas las IP que han realizado un ataque y que han sido bloqueadas por este motivo: http://www.blocklist.de/en/index.html
www.blocklist.de es un servicio gratuito y voluntario proporcionado por un especialista en fraude / abuso, cuyos servidores a menudo son atacados a través de SSH, Mail-Login, FTP, servidor web y otros servicios.
La misión es informar de todos los ataques a los departamentos de abuso respectivos de las PC / servidores infectados, para garantizar que el proveedor responsable pueda informar a sus clientes sobre la infección y desactivar al atacante. Ellos proporcionan una lista de las direcciones IP de los atacantes de las últimas 48 horas por servicio o todas las direcciones para descargar.
Ellos proporcionan la información en txt directamente para que se pueda descargar.
Un ejemplo de la información entregada de ataques al servicio ssh se puede ver en el siguiente enlace: https://lists.blocklist.de/lists/ssh.txt

3.- Determinar los datos que tenemos accesible:
Al verificar que datos tenemos disponibles, podemos ver que a partir de la lista de IP, podríamos obtener coordenadas ciudades y zonas horarias para cada una de las direcciones especificas, básicamente con la IP, podríamos encontrar:
El País, la ciudad, el código de la región, zip, zona horaria, latitud y longitud.

4.- Obtener los datos:
Teniendo en cuenta la información que podríamos obtener, referida en el punto 3 de este documento podemos conseguir esos datos; hacemos lo siguiente:
Obtenemos una función que está pública y es una reutilización de código descargado de un PKG proporcionado en el GitHub de Luis Cape que se puede
Instalar de la siguiente forma install_github('freegeoip', 'luiscape')), Esta función recibe como parámetro un dataframe, que en nuestro caso tiene las direcciones IP.
Lo que hace esta función es que busca en el servicio disponible http://freegeoip.net/json/ y nos entrega la información del punto 3.

5.- Limpiar los datos -> datos elegantes:
Para mostrar los datos de forma adecuada, estamos utilizando dentro de nuestra función la opción rbind que construye un dataframe con todos los datos encontrados en la API http://freegeoip.net/json/, de esta forma obtenemos información clara, además estamos agregando un título llamado IP a cada dataframe utilizado y por último hemos agregado una nueva columna llamada servicio que detalla cual es el tipo de servicio atacado obtenido del conjunto de datos.

6.- Análisis de exploración de datos:
Con el conjunto de datos ya establecido y ordenado vemos que existe un gran numero de registros que tienen zona horaria incluida y que si tomamos una muestra con la función sample siempre encontramos un patrón indicativo de que la mayor cantidad de ip bloquedas vienen de Asia y si agrupamos por sector con la función ClusterOptions vemos en rojo la mayor cantidad de áreas con ataques producidos y por ende bloqueados dentro del conjunto de datos.

7.- Modelos o predicciones estadísticas:
Vemos que al tomar una muestra con la función sample siempre tenemos el mismo comportamiento geográfico, localizando los ataques en asía y Europa.

8.- Interpretar los resultados:
Al ver los resultados podemos observar que existe una gran relación entre los últimos ataques con el acceso que los atacantes tienen a Internet y con el nivel educacional de los países que efectúan estos ataques, mayor educación y mayor acceso a la tecnología, mayor el número de ataques efectuados.

9.- Obtener una respuesta a la pregunta:
Podemos contestar nuestra pregunta inicial ¿Cómo se distribuyen geográficamente los ataques informáticos producidos en el mundo en las últimas 48 horas?
La respuesta es Sí, hemos encontrado la data necesaria para ver de donde vienen estos ataques y además hemos podido graficar esto en un mapa mundial para tener una perspectiva visual de lo que estábamos buscando.

10.- Sintetizar y describir los resultados del proceso:
Al avanzar con este trabajo hemos encontrado una solución para responder nuestra pregunta, los pasos realizados para llegar a este punto fueron los siguientes:
Determinar la pregunta, buscar la fuente de datos, ordenar la información, descubrir los datos y analizarlos, graficar los datos en un mapa. Al llegar a este punto y ver de forma graficas los resultados hemos podido ver de donde vienen los ataques y cual es su tendencia.

11.- Crear un código reproducible:
Para organizar nuestro trabajo hemos utilizado la herramienta Github que utiliza el lenguaje Git, de esta forma hemos trabajado en ramas logrando hacer un código reproducible que cualquier persona puede descargar y reproducir desde la rama Master de nuestros Github: https://github.com/fconcha/dds_practica_master
Además, hemos publicado los resultados en una aplicación web con la herramienta Shinyapps, que se puede ver en el siguiente enlace: https://fconcha.shinyapps.io/bloqueo_de_ip_ataques_en_el_mundo/

La idea de este trabajo es que se pueda utilizar y mejorar por otros contribuyentes e interesados en Driven Security.
Master Cybersecurity Management UPC Barcelona
Muchas Gracias!
