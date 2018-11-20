## Files

[Hive Schema](./credit-card-schema.sql)
[CC Transactions AVRO Schema](./cc-trans.avsc)
[CC Transactions (min) AVRO Schema](./cc-trans-min.avsc)


## Start the CC_TRANS generator

`java -jar $GEN_JAR -cfg cc-trans-gen.yaml -scfg cc-trans-kafka.yaml`

## Kafka

### Create Topic

`/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --if-not-exists --create --topic CC_TRANS_JSON --partitions 20 --replication-factor 2 --zookeeper os04.streever.local:2181`


### List Topics

`/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --list --zookeeper os04.streever.local:2181`


## Checking Client Topic Lag

`/usr/hdp/current/kafka-broker/bin/kafka-consumer-groups.sh --bootstrap-server os10.streever.local:6667 --group CC_TRANS_NIFI_1 --describe`

## Start the CC_ACCT generator

`java -jar $GEN_JAR -cfg cc-acct-gen.yaml -scfg cc-acct-kafka.yaml`

