-- 复原 2026-11-02 09:00:00Z 时点系统里实际有的数据
-- 口径：published_at 与 ingested_at 都不晚于截止时点才可用；
--       在可用版本里按 revision 取最新；空值不补（最新可用版本为空则结果为空）；
--       范围以 universe 为准。
-- 时间字段均为 'YYYY-MM-DDTHH:MM:SSZ' 格式，字符串比较与时间比较等价。
-- 表名对应三个 csv：source_observations、universe、research-snapshot（本查询不读快照）。

WITH params AS (
    SELECT '2026-11-02T09:00:00Z' AS cutoff
),
visible AS (
    SELECT o.*
    FROM source_observations AS o
    CROSS JOIN params AS p
    WHERE o.published_at <= p.cutoff
      AND o.ingested_at <= p.cutoff
),
ranked AS (
    SELECT
        v.*,
        ROW_NUMBER() OVER (
            PARTITION BY v.security_id, v.event_date
            ORDER BY v.revision DESC, v.published_at DESC, v.ingested_at DESC, v.row_no DESC
        ) AS rn
    FROM visible AS v
)
SELECT
    u.security_id,
    r.event_date,
    r.return_bps,
    r.revision,
    r.published_at,
    r.ingested_at,
    r.row_no
FROM universe AS u
LEFT JOIN ranked AS r
    ON r.security_id = u.security_id
   AND r.rn = 1
ORDER BY u.security_id;
