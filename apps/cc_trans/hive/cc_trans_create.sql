create database if not exists streaming;

use streaming;

drop table cc_trans;
create table if not exists cc_trans (
cc_trans string,
ccn string,
trans_ts string,
mcc int,
mrch_id string,
st string,
amnt double
);

create table if not exist cc_trans_min (
cc_trans string,
ccn string,
trans_ts timestamp,
st string,
amnt double
);

create external table if not exists ext_cc_trans (
cc_trans string,
ccn string,
trans_ts timestamp,
mcc int,
mrch_id string,
st string,
amnt double
)
ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
 STORED AS TEXTFILE
 LOCATION '/user/nifi/datasets/external/cc_trans';
 
 create external table if not exists ext_cc_trans_min (
cc_trans string,
ccn string,
trans_ts timestamp,
st string,
amnt double
)
ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
 STORED AS TEXTFILE
 LOCATION '/user/nifi/datasets/external/cc_trans_min';