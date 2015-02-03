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

1. Clone the repo:

```
cd /tmp && git clone https://github.com/sakserv/mypipe-example.git
```

2. Build the project using maven

```
cd /tmp/mypipe-example && mvn clean package
```

3. Setup mypipe

```
cd /tmp/mypipe-example && bin/mypipe.sh
```