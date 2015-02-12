#!/bin/bash

# Create the Kafka Topic
echo -e "\n#### Creating the Kafka Topic: test_topic"
/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --topic test_topic --zookeeper localhost:2181 --partitions 1 --replication-factor 1
