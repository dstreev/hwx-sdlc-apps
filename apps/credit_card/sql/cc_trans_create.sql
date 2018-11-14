CREATE database
IF NOT EXISTS ${database};

USE ${database};

--drop table cc_trans;
CREATE TABLE
    IF NOT EXISTS cc_trans
    (
      cc_trans string,
      ccn string     ,
      trans_ts timestamp,
      mcc INT        ,
      mrch_id string ,
      st string      ,
      amnt DOUBLE
    )
     PARTITIONED BY (processed_dt STRING, processed_hour STRING);

CREATE external TABLE
IF NOT EXISTS cc_trans_min_ext_stream (cc_trans string, ccn string, trans_ts TIMESTAMP,
  st string, amnt DOUBLE)
  PARTITIONED BY (processed_dt STRING, processed_hour STRING)
  ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE
  LOCATION '/user/nifi/datasets/external/cc_trans_min';


