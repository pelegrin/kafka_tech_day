#!/bin/bash
sed -i "s/zookeeper\.connect=.*/zookeeper\.connect=${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT}/" config/server.properties
sed -i "s/#listeners=PLAINTEXT.*/listeners=PLAINTEXT\:\/\/${KAFKA_HOST}:${KAFKA_PORT}/" config/server.properties
sed -i "s/broker\.id=.*/broker\.id=${KAFKA_ID}/" config/server.properties
sed -i "s/num\.partitions=.*/num\.partitions=${KAFKA_PARTITIONS}/" config/server.properties
/bin/bash bin/kafka-server-start.sh config/server.properties