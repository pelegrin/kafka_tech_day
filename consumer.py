#!python3

import sys
from pykafka import KafkaClient
from pykafka.exceptions import SocketDisconnectedError, ConsumerStoppedException

if len(sys.argv) < 2:
    print ("Usage is " + sys.argv[0] + " <topic_name>")
    exit(1)

topicName = sys.argv[1]
kafkaBrokers = 'localhost:9092, localhost:9093'

#Configure consumer
client = KafkaClient(kafkaBrokers)
topic = client.topics[topicName]
balanced_consumer = topic.get_balanced_consumer(
    consumer_group='test1',
    auto_commit_enable=True,
    zookeeper_connect='localhost:2181'    
)

#Consume messages
try:
    for message in balanced_consumer:
        if message is not None:
            print ("Received offset: " + str(message.offset) +" message:" + message.value.decode())

except KeyboardInterrupt:
    sys.exit()

except (SocketDisconnectedError, ConsumerStoppedException) as e:
    balanced_consumer.stop()
    balanced_consumer.start()
