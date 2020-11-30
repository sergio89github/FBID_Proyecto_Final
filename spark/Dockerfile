#image_worker
FROM bde2020/spark-worker:2.4.4-hadoop2.7

COPY ./flight_prediction_2.11-0.4.jar /jar/flight_prediction_2.11-0.4.jar
CMD spark/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --packages org.mongodb.spark:mongo-spark-connector_2.11:2.4.1,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.4 \
--master local /jar/flight_prediction_2.11-0.4.jar








