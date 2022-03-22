FROM alpine:3.14
LABEL Name=zookeeper Version=3.6.3
RUN apk add --update curl tar procps bash openjdk11 netcat-openbsd && \
    rm -rf /var/cache/apk/*
ENV ZOOKEEPER="apache-zookeeper-3.6.3-bin"
RUN curl -O https://dlcdn.apache.org/zookeeper/zookeeper-3.6.3/${ZOOKEEPER}.tar.gz  && \
    tar xzf "${ZOOKEEPER}.tar.gz" && \
    rm -fr "${ZOOKEEPER}.tar.gz"       
WORKDIR /$ZOOKEEPER
RUN mv conf/zoo_sample.cfg conf/zoo.cfg
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=5\
  CMD nc -z localhost 2181 || exit 1
ENTRYPOINT ["bash", "bin/zkServer.sh", "start-foreground" ]
