#!/bin/bash
echo "Practica Final de FBID > Prediccion de vuelos"
sleep 5
echo "Descargando datos"
sleep 10
echo "Desplegando servicios"
docker stack deploy --compose-file docker-compose.yml fbid_deploy
echo "Ejecutando modelo"
sleep 40
docker exec -it $(docker ps | grep "image_mongo" | awk '{print $1}') /opt/import_distances.sh
