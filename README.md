# PROYECTO FBID FINAL

Javier Cinca Pérez

Jaime De Vivar Adrada

Sergio Juliano Griñan Aguila

## GitHub del Proyecto
[https://github.com/sergio89github/FBID_Proyecto_Final](https://github.com/sergio89github/FBID_Proyecto_Final)

## Instalacion del escenario 

Seguir las instrucciones dadas en el siguiente enlace:

[https://github.com/ging/practica_big_data_2019](https://github.com/ging/practica_big_data_2019)

Seguir las indicaciones paso a paso y tener cuidado con ciertos aspectos:
-	El python debe ser 3.6.9 o inferior ya que si no, el entrenamiento del modelo no se realiza correctamente. Por ejemplo, en caso de realizar el proyecto desde cero sobre Ubuntu es preferible utilizar Ubuntu 18.04 antes que Ubuntu 20.04 ya que por tema de compatibilidad es más sencillo. 
-	Las versiones de spark y kafka deben ser las especificadas en el enlace, si no, no funciona adecuadamente. 
-	Instalar la versión de java 1.8.
-	A la hora de abrir el escenario en Intellij elegir la carpeta flight_prediction porque de otro modo el build no se realiza de manera adecuada y no se ejecutará MakePrediction. 
-	Definir correctamente los paths: JAVA_HOME, SPARK_HOME y PROJECT_HOME.  En concreto en java_home se debe especificar la ruta que aparece en el enlace sin la carpeta bin del final. 


## Exportación del JAR y ejecución de spark_submit.

Una vez comprobado que el fichero MakePrediction funciona habrá que exportar el JAR, para ello realizaremos los siguientes pasos:
- Primero, navegue a File -> Project Structure y haga clic en Artifacts.
- Haga clic en el botón + y seleccione JAR -> From modules with dependencies.
- Seleccione su módulo de la lista desplegable y el archivo principal (este es el archivo que contiene su método public static void main(). Habrá que seleccionar la opción: “extract to the target JAR”.
- Haga clic en OK , verifique que toda la información relacionada con las dependencias sea correcta y haga OK para finalizar la configuración del artefacto.
- Posteriormente haga clic en Build -> Build Artifacts y haga clic en Build en el menú.
- El jar se encontrará en la build -> classes -> artifacts.
	



Otra opción para obtener el JAR es: 
- Abrir la carpeta practica_big_data_2019 en un terminal.
- Ejecutar el comando: “ cd flight_prediction”
- Ejecutar: “ sbt compile”
- Ejecutar: “ sbt package”


Habiendo realizado estos pasos ya tendremos disponible el jar con el que ejecutar el spark submit, para ello:
- Configuramos el path donde se encuentre el archivo de spark_submit dentro de la carpeta spark, una posible ruta podría ser:  “alias spark-submit='/home/user/Escritorio/servers/spark.../bin/spark-submit”.
- Ejecutamos el siguiente comando para arrancar el programa desde SBT: “spark-submit --class es.upm.dit.ging.predictor.MakePrediction --packages org.mongodb.spark:mongo-spark-connector_2.11:2.4.1,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.7 target/scala-2.11/flight_prediction_2.11-0.1.jar”. 
De esta manera habremos conseguido ejecutar el proyecto sin necesidad de acceder a Intellij. 
- Abrimos un navegador y abrimos el siguiente enlace: 
“http://localhost:5000/flights/delays/predict_kafka”.




## Despliegue del escenario con Docker.

Para ello habrá que:
- Descargarse el siguiente repositorio Github con el siguiente comando:  “git clone ……. “
- Descomprimir el zip del proyecto. 
La carpeta contendrá los diferentes contenedores docker con las imágenes de los distintos componentes que forman el proyecto que, posteriormente, se desplegarán. Una vez descargado y descomprimido abrimos con un terminal la carpeta y ejecutando el siguiente comando se desplegará el proyecto:
```
./deploy.sh
```
Podremos utilizar los siguientes comandos docker para obtener información sobre los diferentes contenedores e imágenes: 
```
 sudo docker images ls
 sudo docker ps
 sudo docker logs <container ID>
```

## Despliegue con docker-compose. 

Desplegamos las aplicaciones en modo servicio, utilizando un stack de docker, el cual nos permite mantener los microservicios vivos todo el tiempo, asegurando la resiliencia de nuestro proyecto. Antes de la ejecución del docker stack deploy es necesario construir las imágenes de los servicios de Mongo, Web Flask y Spark-Worker, estas recetas se encuentran en el Dockerfile de cada directorio nombrado con el nombre del servicio. Una vez comprobado que los contenedores se han desplegado mediante la inspección de las réplicas de cada instancia, podemos pasar a inspeccionar los logs de cada servicio . Posteriormente accedemos a la web para realizar la predicción. 

En la carpeta raíz del proyecto ejecutar:

```
./deploy.sh
docker build -t <nombre_dela_imagen> .
docker stack deploy --compose-file docker-compose <nombre_del_stack>
docker service logs -f <nombre_dela_instancia>
docker stats 
```

