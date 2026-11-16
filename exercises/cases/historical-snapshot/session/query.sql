-- Point-in-time check of research-snapshot.csv against source-observations.csv.
--
-- As-of instant : 2026-11-02 09:00:00 UTC
-- Availability  : published_at <= as_of AND ingested_at <= as_of
-- Selection     : among available versions, the highest revision
--                 (ties broken by published_at, ingested_at, row_no)
-- Nulls         : a null in the selected version stays null; no fallback
-- Scope         : universe.csv, restricted to the review batch below
--
-- Run from the directory holding the three CSV files:
--   duckdb -no-agent < query.sql
-- The CSV files are only read.

SET TimeZone = 'UTC';

WITH params AS (
    SELECT TIMESTAMPTZ '2026-11-02 09:00:00+00' AS as_of
),
scope AS (
    SELECT security_id
    FROM read_csv('universe.csv', header = true,
                  columns = {'security_id': 'VARCHAR'})
    -- Review batch 1. Remove this filter to cover the whole universe.
    WHERE security_id IN ('S01', 'S02', 'S03')
),
obs AS (
    SELECT o.*,
           o.published_at <= p.as_of AS published_in_time,
           o.ingested_at <= p.as_of AS ingested_in_time
    FROM read_csv('source-observations.csv', header = true,
                  columns = {'row_no': 'BIGINT',
                             'security_id': 'VARCHAR',
                             'event_date': 'DATE',
                             'published_at': 'TIMESTAMPTZ',
                             'ingested_at': 'TIMESTAMPTZ',
                             'revision': 'INTEGER',
                             'return_bps': 'BIGINT'}) AS o
    CROSS JOIN params AS p
),
snap AS (
    SELECT *
    FROM read_csv('research-snapshot.csv', header = true,
                  columns = {'security_id': 'VARCHAR',
                             'event_date': 'DATE',
                             'return_bps': 'BIGINT'})
),
-- One expected row per in-scope security and event date.
event_dates AS (
    SELECT event_date FROM obs
    UNION
    SELECT event_date FROM snap
),
grid AS (
    SELECT s.security_id, d.event_date
    FROM scope AS s
    CROSS JOIN event_dates AS d
),
available AS (
    SELECT *
    FROM obs
    WHERE published_in_time AND ingested_in_time
),
-- Latest available version per key, with tie diagnostics.
picked AS (
    SELECT security_id, event_date, row_no, revision, published_at,
           ingested_at, return_bps,
           count(*) OVER top_rev AS rows_at_picked_revision,
           count(DISTINCT coalesce(CAST(return_bps AS VARCHAR), 'NULL'))
               OVER top_rev AS distinct_values_at_picked_revision
    FROM available
    WINDOW top_rev AS (PARTITION BY security_id, event_date, revision)
    QUALIFY row_number() OVER (
        PARTITION BY security_id, event_date
        ORDER BY revision DESC, published_at DESC, ingested_at DESC,
                 row_no DESC
    ) = 1
),
-- Why the other versions were not used.
source_summary AS (
    SELECT security_id, event_date,
           count(*) AS source_rows,
           count(*) FILTER (WHERE published_in_time AND ingested_in_time)
               AS available_rows,
           string_agg(
               'rev ' || revision || ' (row ' || row_no || ', value '
               || coalesce(CAST(return_bps AS VARCHAR), 'NULL') || '): '
               || CASE
                      WHEN NOT published_in_time AND NOT ingested_in_time
                          THEN 'published and ingested after as-of'
                      WHEN NOT published_in_time
                          THEN 'published after as-of'
                      ELSE 'ingested after as-of'
                  END,
               '; ' ORDER BY revision, row_no
           ) FILTER (WHERE NOT (published_in_time AND ingested_in_time))
               AS excluded_versions
    FROM obs
    GROUP BY security_id, event_date
)
SELECT g.security_id,
       g.event_date,
       k.return_bps AS pit_return_bps,
       CASE
           WHEN ss.source_rows IS NULL THEN 'no source rows'
           WHEN ss.available_rows = 0 THEN 'no version available at as-of'
           WHEN k.return_bps IS NULL
               THEN 'latest available version is null (not filled)'
           ELSE 'ok'
       END AS pit_status,
       k.revision AS pit_revision,
       k.row_no AS pit_row_no,
       k.published_at AS pit_published_at,
       k.ingested_at AS pit_ingested_at,
       k.rows_at_picked_revision,
       k.distinct_values_at_picked_revision,
       ss.excluded_versions,
       sn.security_id IS NOT NULL AS in_snapshot,
       sn.return_bps AS snapshot_return_bps,
       sn.return_bps - k.return_bps AS snapshot_minus_pit,
       CASE
           WHEN sn.security_id IS NULL AND k.return_bps IS NULL
               THEN 'match: absent in both'
           WHEN sn.security_id IS NULL
               THEN 'DIFF: missing from snapshot'
           WHEN sn.return_bps IS NULL AND k.return_bps IS NULL
               THEN 'match: null in both'
           WHEN k.return_bps IS NULL
               THEN 'DIFF: snapshot has a value, point-in-time has none'
           WHEN sn.return_bps IS NULL
               THEN 'DIFF: snapshot is null, point-in-time has a value'
           WHEN sn.return_bps = k.return_bps THEN 'match'
           ELSE 'DIFF: value differs'
       END AS comparison
FROM grid AS g
LEFT JOIN picked AS k USING (security_id, event_date)
LEFT JOIN source_summary AS ss USING (security_id, event_date)
LEFT JOIN snap AS sn USING (security_id, event_date)
ORDER BY g.security_id, g.event_date;
