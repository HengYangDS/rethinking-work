-- Separate source exceptions from snapshot differences; never turn unknown returns into zero.
CREATE VIEW source AS SELECT * FROM read_csv_auto('source-observations.csv');
CREATE VIEW universe AS SELECT * FROM read_csv_auto('universe.csv');
CREATE VIEW eligible AS
SELECT s.* FROM source s JOIN universe USING(security_id)
WHERE event_date = DATE '2026-10-30'
AND published_at <= TIMESTAMPTZ '2026-11-02 09:00:00+00'
AND ingested_at <= TIMESTAMPTZ '2026-11-02 09:00:00+00';
CREATE VIEW frozen AS
SELECT * EXCLUDE(rn) FROM (
 SELECT *, ROW_NUMBER() OVER (
 PARTITION BY security_id,event_date
 ORDER BY revision DESC,published_at DESC,ingested_at DESC,row_no DESC
 ) AS rn FROM eligible
) WHERE rn=1;
SELECT security_id,reason FROM (
 SELECT security_id,'missing_return' AS reason FROM frozen WHERE return_bps IS NULL
 UNION ALL
 SELECT u.security_id,'not_available_at_cutoff' AS reason
 FROM universe u WHERE NOT EXISTS (SELECT 1 FROM frozen f WHERE f.security_id=u.security_id)
 UNION ALL
 SELECT DISTINCT s.security_id,'outside_universe' AS reason
 FROM source s WHERE NOT EXISTS (SELECT 1 FROM universe u WHERE u.security_id=s.security_id)
) ORDER BY security_id;
