CREATE DATABASE IF NOT EXISTS ${database};

USE ${database};

CREATE TABLE IF NOT EXISTS CC_ACCT (
  CCN STRING,
  FIRST_NAME STRING,
  LAST_NAME STRING,
  STREET_NUM INT,
  STREET STRING,
  STATE STRING,
  LAST_UPDATE_TS TIMESTAMP
);

CREATE TABLE IF NOT EXISTS CC_ACCT_DELTA (
  CCN STRING,
  FIRST_NAME STRING,
  LAST_NAME STRING,
  STREET_NUM INT,
  STREET STRING,
  STATE STRING,
  LAST_UPDATE_TS TIMESTAMP
)
PARTITIONED BY (PROCESSING_CYCLE TIMESTAMP);

CREATE TABLE IF NOT EXISTS CC_TRANS (
  CC_TRANS STRING,
  CCN STRING     ,
  TRANS_TS timestamp,
  MCC INT        ,
  MRCH_ID STRING ,
  STATE STRING      ,
  AMNT DOUBLE
)
PARTITIONED BY (PROCESSING_CYCLE TIMESTAMP);

CREATE external TABLE
IF NOT EXISTS cc_trans_min_ext_stream (cc_trans string, ccn string, trans_ts TIMESTAMP,
  st string, amnt DOUBLE)
  PARTITIONED BY (processed_dt STRING, processed_hour STRING)
  ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE
  LOCATION '/user/nifi/datasets/external/cc_trans_min';

-- Account Aggregates Daily
CREATE TABLE IF NOT EXISTS CC_ACCT_DAILY (
  CCN STRING,
  TOTAL_AMOUNT DOUBLE
)
PARTITIONED BY (PROCESSING_DT STRING);

-- Merchant Aggregates Daily
CREATE TABLE IF NOT EXISTS CC_MRCH_DAILY (
  MRCH_ID STRING,
  TOTAL_AMOUNT DOUBLE
)
PARTITIONED BY (PROCESSING_DT STRING);