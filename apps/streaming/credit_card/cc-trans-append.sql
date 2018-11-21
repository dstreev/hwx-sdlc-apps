USE ${database};

FROM CC_TRANS_BRIDGE
SELECT
  CC_TRANS,CCN,TRANS_TS,MCC,MRCH_ID,STATE,AMNT
WHERE
  MINUTE_OF_DAY=${last.delta.processing.cycle.int}
INSERT INTO TABLE CC_TRANS PARTITION ('${acid.processing.cycle.string}')
