MyPipe Example
--------------

[mypipe](https://github.com/mardambey/mypipe) is a MySQL binlog -> Kafka replicator.

The goal of this project is to demonstrate the following data pipeline:

1. MySQL RDS binlog -> mypipe
2. mypipe -> Kafka
3. Kafka -> Storm KafkaSpout
4. Storm KafkaSpout -> Storm MongodbBolt
5. Storm MongodbBolt -> MongoDB
