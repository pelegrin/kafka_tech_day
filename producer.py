#!python3

import sys
from pykafka import KafkaClient

if len(sys.argv) < 2:
    print ("Usage is " + sys.argv[0] + " <topic_name>")
    exit(1)

topicName = sys.argv[1]
kafkaBrokers = 'localhost:9092,localhost:9093'

#Configure producer
client = KafkaClient(kafkaBrokers)
topic = client.topics[topicName]
producer = topic.get_producer()

#Produce messages
count = 0
try:
    while True:
        message = input()
        if not message:
            break
        count = 0 if count == 1 else 1
        producer.produce(bytes(message, 'utf-8'), partition_key = bytes(count))
        print ("Sent to topic: " + topicName + " message: " + message)

except KeyboardInterrupt:
    sys.exit()
