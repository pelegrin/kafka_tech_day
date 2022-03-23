#!python3

import sys
from pykafka import KafkaClient

if len(sys.argv) < 2:
    print ("Usage is " + sys.argv[0] + " <topic_name>")
    exit(1)

topicName = sys.argv[1]
kafkaBrokers = 'localhost:9092,localhost:9093'

#Configure consumer
client = KafkaClient(kafkaBrokers)
topic = client.topics[topicName]
consumer = topic.get_simple_consumer()

#Consume messages
try:
    for message in consumer:
        if message is not None:
            print ("Received offset: " + str(message.offset) +" message:" + message.value.decode())

except KeyboardInterrupt:
    sys.exit()
