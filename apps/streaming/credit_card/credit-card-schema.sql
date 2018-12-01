CREATE DATABASE
IF NOT EXISTS ${database};

USE ${database};

DROP TABLE
    IF EXISTS CC_ACCT;
CREATE TABLE
    IF NOT EXISTS CC_ACCT
    (
      CCN STRING       ,
      FIRST_NAME STRING,
      LAST_NAME STRING ,
      STREET_NUM INT   ,
      STREET STRING    ,
      STATE STRING     ,
      LAST_UPDATE_TS TIMESTAMP
    ) ;

DROP TABLE
    IF EXISTS CC_ACCT_DELTA;
    
CREATE TABLE
    IF NOT EXISTS CC_ACCT_DELTA
    (
      CCN STRING       ,
      FIRST_NAME STRING,
      LAST_NAME STRING ,
      STREET_NUM INT   ,
      STREET STRING    ,
      ST STRING     ,
      LAST_UPDATE_TS TIMESTAMP
    )
    PARTITIONED BY
    (
      PROCESSING_CYCLE TIMESTAMP
    ) ;

DROP TABLE
    IF EXISTS CC_TRANS;
DROP TABLE
    IF EXISTS CC_TRANS_FROM_STREAMING;
DROP TABLE
    IF EXISTS CC_TRANS_FROM_INCREMENTAL_APPEND;

CREATE TABLE
    IF NOT EXISTS CC_TRANS_FROM_STREAMING
    (
      CC_TRANS STRING   ,
      CCN STRING        ,
      TRANS_TS TIMESTAMP,
      MCC INT           ,
      MRCH_ID STRING    ,
      STATE STRING      ,
      AMNT DOUBLE
    )
    PARTITIONED BY
    (
      PROCESSING_CYCLE STRING
    )
    TBLPROPERTIES
    (
      'transactional_properties'='insert_only'
    ) ;

CREATE TABLE
    IF NOT EXISTS CC_TRANS_FROM_INCREMENTAL_APPEND
    (
      CC_TRANS STRING   ,
      CCN STRING        ,
      TRANS_TS TIMESTAMP,
      MCC INT           ,
      MRCH_ID STRING    ,
      STATE STRING      ,
      AMNT DOUBLE
    )
    PARTITIONED BY
    (
      PROCESSING_CYCLE STRING
    );
    
DROP TABLE
    CC_TRANS_BRIDGE;

CREATE EXTERNAL TABLE
IF NOT EXISTS CC_TRANS_BRIDGE(CC_TRANS STRING, CCN STRING , TRANS_TS BIGINT, MCC INT , MRCH_ID
  STRING , ST STRING , AMNT DOUBLE) PARTITIONED BY(PROCESSING_CYCLE STRING) ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ','STORED AS TEXTFILE LOCATION
  '/user/nifi/datasets/external/cc_trans_bridge';

CREATE EXTERNAL TABLE
IF NOT EXISTS cc_trans_min_ext_stream(cc_trans string, ccn string, trans_ts TIMESTAMP, st string,
  amnt DOUBLE) PARTITIONED BY(processed_dt STRING, processed_hour STRING) ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/nifi/datasets/external/cc_trans_min';

-- Account Aggregates Daily
DROP TABLE IF EXISTS CC_ACCT_DAILY;
CREATE TABLE
    IF NOT EXISTS CC_ACCT_DAILY
    (
      CCN STRING,
      TOTAL_AMOUNT DOUBLE
    )
    PARTITIONED BY
    (
      PROCESSING_DT STRING
    ) ;


-- Merchant Aggregates Daily
DROP TABLE IF EXISTS CC_MRCH_DAILY;
CREATE TABLE
    IF NOT EXISTS CC_MRCH_DAILY
    (
      MRCH_ID STRING,
      TOTAL_AMOUNT DOUBLE
    )
    PARTITIONED BY
    (
      PROCESSING_DT STRING
    ) ;

DROP TABLE IF EXISTS STATE_RAW;
CREATE EXTERNAL TABLE STATE_RAW(ST STRING, STATE STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY
','STORED AS TEXTFILE LOCATION '/user/nifi/datasets/external/states';

DROP TABLE IF EXISTS STATE;
CREATE TABLE IF NOT EXISTS
    STATE
    (
      ST STRING,
      STATE STRING
    ) ;
    
INSERT OVERWRITE TABLE STATE SELECT ST, STATE FROM STATE_RAW; 
