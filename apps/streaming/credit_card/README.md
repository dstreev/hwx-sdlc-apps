## Files

[Hive Schema](./credit-card-schema.sql)
[CC Transactions AVRO Schema](./cc-trans.avsc)
[CC Transactions (min) AVRO Schema](./cc-trans-min.avsc)


## Start the CC_TRANS generator

`java -jar $GEN_JAR -cfg cc-trans-gen.yaml -scfg cc-trans-kafka.yaml`

## Build Kafka Topic

`./kafka-topics.sh --if-not-exists --create --topic CC_TRANS_JSON --partitions 20 --replication-factor 2 --zookeeper os04.streever.local:2181`

## Checking Client Topic Lag

