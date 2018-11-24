USE ${database};

ALTER TABLE CC_TRANS_BRIDGE ADD IF NOT EXISTS PARTITION (processing_cycle="${last.delta.processing.cycle}");

FROM CC_TRANS_BRIDGE
INSERT INTO TABLE CC_TRANS PARTITION (PROCESSING_CYCLE="${acid.processing.cycle.string}")
SELECT
  CC_TRANS,CCN,TRANS_TS,MCC,MRCH_ID,STATE,AMNT
WHERE
  PROCESSING_CYCLE="${last.delta.processing.cycle}";