FROM alpine:3.14
LABEL Name=sample Version=0.1
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN ps -f
RUN echo "hello" > /info.log
ENTRYPOINT [ "tail", "-f", "/info.log"]