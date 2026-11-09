-- All timestamps are UTC. This is operational availability, not public availability alone.
CREATE VIEW eligible AS
SELECT o.* FROM read_csv_auto('source-observations.csv') o
JOIN read_csv_auto('universe.csv') u USING(security_id)
WHERE event_date = DATE '2026-10-30'
AND published_at <= TIMESTAMPTZ '2026-11-02 09:00:00+00'
AND ingested_at <= TIMESTAMPTZ '2026-11-02 09:00:00+00';
CREATE VIEW frozen AS
SELECT * EXCLUDE(rn) FROM (
 SELECT *, ROW_NUMBER() OVER (
  PARTITION BY security_id, event_date
  ORDER BY revision DESC, published_at DESC, ingested_at DESC, row_no DESC
 ) AS rn FROM eligible
) WHERE rn = 1;
CREATE VIEW accepted AS
SELECT security_id,event_date,return_bps FROM frozen WHERE return_bps IS NOT NULL;
SELECT COALESCE(a.security_id,s.security_id) AS security_id,
 a.return_bps AS expected_bps, s.return_bps AS snapshot_bps,
 CASE WHEN a.security_id IS NULL THEN 'not_accepted_at_cutoff'
 WHEN s.security_id IS NULL THEN 'missing_in_snapshot'
 ELSE 'value_mismatch' END AS reason,
 a.return_bps-s.return_bps AS delta_bps
FROM accepted a FULL JOIN read_csv_auto('research-snapshot.csv') s
USING(security_id,event_date)
WHERE a.security_id IS NULL OR s.security_id IS NULL
OR a.return_bps IS DISTINCT FROM s.return_bps
ORDER BY security_id;
