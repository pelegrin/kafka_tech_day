FROM alpine:3.14
LABEL Name=kafka Version=2.13-3.1.0
RUN apk add --update curl tar bash openjdk11 && \
    rm -rf /var/cache/apk/*
ENV KAFKA="kafka_2.13-3.1.0"
ENV ZOOKEEPER_HOST="localhost"
ENV ZOOKEEPER_PORT="2181"
ENV KAFKA_HOST="localhost"
ENV KAFKA_PORT="9092"
ENV KAFKA_ID=0
ENV KAFKA_PARTITIONS=1     
RUN curl -O https://dlcdn.apache.org/kafka/3.1.0/${KAFKA}.tgz && \
    tar xzf "${KAFKA}.tgz" && \
    rm -fr "${KAFKA}.tgz"       
WORKDIR /$KAFKA
ADD kafka-wrapper.sh .
RUN chmod +x ./kafka-wrapper.sh    
ENTRYPOINT ["bash", "kafka-wrapper.sh" ]
