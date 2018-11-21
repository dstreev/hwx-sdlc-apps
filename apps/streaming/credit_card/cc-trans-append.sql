USE ${database};

FROM CC_TRANS_BRIDGE
SELECT
  CC_TRANS,CCN,TRANS_TS,MCC,MRCH_ID,STATE,AMNT
WHERE
  MINUTE_OF_DAY=${last.processing.cycle}
INSERT INTO CC_TRANS PARTITION ("${acid.processing.cycle.string}");
