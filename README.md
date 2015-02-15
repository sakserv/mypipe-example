MyPipe Example
--------------

[mypipe](https://github.com/mardambey/mypipe) is a MySQL binlog -> Kafka replicator.

The goal of this project is to demonstrate the following data pipeline:

1. MySQL RDS binlog -> mypipe
2. mypipe -> Kafka
3. Kafka -> Storm KafkaSpout
4. Storm KafkaSpout -> Storm MongodbBolt
5. Storm MongodbBolt -> MongoDB

Usage
-----

The following outlines how to use this project.

* Clone the repo:
```
cd /tmp && git clone https://github.com/sakserv/mypipe-example.git
```

* Install and start MongoDB
```
cd /tmp/mypipe-example && bash -x bin/install_mongo.sh
```

* Create the Kafka Topic (if auto creation of topics is disabled)
```
cd /tmp/mypipe-example && bash -x bin/create_kafka_topic.sh
```

* Start mypipe
```
cd /tmp/mypipe-example && bash -x bin/mypipe.sh
```
