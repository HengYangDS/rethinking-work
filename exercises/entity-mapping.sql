CREATE TABLE mappings AS
SELECT entity_id, owner_id,
       valid_from::TIMESTAMPTZ AS valid_from,
       valid_to::TIMESTAMPTZ AS valid_to
FROM read_csv_auto('entity-mappings.csv');

CREATE TABLE events AS
SELECT event_id, entity_id, event_at::TIMESTAMPTZ AS event_at
FROM read_csv_auto('entity-events.csv');

-- Resolve event ownership
SELECT e.event_id,
       CASE WHEN count(m.owner_id) = 1 THEN min(m.owner_id) END AS owner_id,
       CASE count(m.owner_id)
         WHEN 0 THEN 'unmapped'
         WHEN 1 THEN 'resolved'
         ELSE 'ambiguous'
       END AS mapping_status
FROM events e LEFT JOIN mappings m
  ON e.entity_id = m.entity_id
 AND e.event_at >= m.valid_from
 AND (m.valid_to IS NULL OR e.event_at < m.valid_to)
GROUP BY e.event_id
ORDER BY e.event_id;
