-- 复原 2026-11-02T09:00:00Z 系统内实际可用的观测值
-- 可用：published_at 与 ingested_at 都不晚于截止时刻
-- 取：可用版本中 revision 最大者（并列时取较晚的 published_at / ingested_at，再取 row_no）
-- 空值不补：可用版本的 return_bps 为空则保持为空
-- 范围：universe.csv。本轮只做 S01、S02、S03，其余证券确认后再加入
-- 时间均为同格式 UTC ISO-8601（以 Z 结尾），字符串比较即可

CREATE VIEW restored_at_cutoff AS
WITH cutoff AS (
  SELECT '2026-11-02T09:00:00Z' AS t
),
scope AS (
  SELECT u.security_id
  FROM universe u
  WHERE u.security_id IN ('S01', 'S02', 'S03')
),
avail AS (
  SELECT o.*
  FROM source_observations o
  JOIN scope s ON s.security_id = o.security_id
  CROSS JOIN cutoff c
  WHERE o.published_at <= c.t
    AND o.ingested_at <= c.t
),
ranked AS (
  SELECT a.*,
         ROW_NUMBER() OVER (
           PARTITION BY a.security_id, a.event_date
           ORDER BY a.revision DESC, a.published_at DESC, a.ingested_at DESC, a.row_no DESC
         ) AS rn
  FROM avail a
)
SELECT security_id, event_date, revision, published_at, ingested_at, return_bps
FROM ranked
WHERE rn = 1;

-- 查询 1：范围内每只证券的复原值；没有值的写明原因
SELECT s.security_id,
       r.event_date,
       r.revision,
       r.published_at,
       r.ingested_at,
       r.return_bps,
       CASE
         WHEN r.security_id IS NULL THEN '截止时刻前无可用版本'
         WHEN r.return_bps IS NULL THEN '可用版本的值为空'
       END AS reason
FROM universe u
JOIN (SELECT 'S01' AS security_id UNION ALL SELECT 'S02' UNION ALL SELECT 'S03') s
  ON s.security_id = u.security_id
LEFT JOIN restored_at_cutoff r ON r.security_id = s.security_id
ORDER BY s.security_id;

-- 查询 2：与 research-snapshot.csv 逐只比较
SELECT s.security_id,
       r.return_bps AS restored_bps,
       n.return_bps AS snapshot_bps,
       CASE
         WHEN n.security_id IS NULL THEN '快照缺该证券'
         WHEN r.return_bps IS NULL AND n.return_bps IS NULL THEN '一致（均为空）'
         WHEN r.return_bps IS NULL OR n.return_bps IS NULL THEN '不一致（一方为空）'
         WHEN r.return_bps = n.return_bps THEN '一致'
         ELSE '不一致'
       END AS comparison
FROM universe u
JOIN (SELECT 'S01' AS security_id UNION ALL SELECT 'S02' UNION ALL SELECT 'S03') s
  ON s.security_id = u.security_id
LEFT JOIN restored_at_cutoff r ON r.security_id = s.security_id
LEFT JOIN research_snapshot n ON n.security_id = s.security_id
ORDER BY s.security_id;
