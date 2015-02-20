#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: must supply the name of the topic you want to create"
  exit 1
fi
topic="$1"

# Create the Kafka Topic
echo -e "\n#### Creating the Kafka Topic: $topc"
/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --topic $topic --zookeeper localhost:2181 --partitions 1 --replication-factor 1
