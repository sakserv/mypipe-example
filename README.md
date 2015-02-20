MyPipe Example
--------------

[mypipe](https://github.com/mardambey/mypipe) is a MySQL binlog -> Kafka replicator.

The goal of this project is to demonstrate the following data pipeline:

1. MySQL RDS binlog -> mypipe
2. mypipe -> Kafka

Usage
-----

The following outlines how to use this project.

* Clone the repo:
```
cd /tmp && git clone https://github.com/sakserv/mypipe-example.git
```

```

* Create the Kafka Topic (if auto creation of topics is disabled)
```
cd /tmp/mypipe-example && bash -x bin/create_kafka_topic.sh <topic_name>
Note: MyPipe uses the following for topic name: <database>_<table>_generic
```

* Start mypipe
```
cd /tmp/mypipe-example && bash -x bin/mypipe.sh
```
