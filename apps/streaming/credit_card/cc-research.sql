use ${database};

MSCK REPAIR TABLE CC_TRANS_BRIDGE;

SHOW PARTITIONS CC_TRANS_BRIDGE;

SHOW TABLES;

alter table CC_TRANS DROP PARTITION (processing_cycle='2018-11-21');

show create table cc_trans_bridge;

select processing_cycle, count(cc_trans) from CC_TRANS group by processing_cycle;