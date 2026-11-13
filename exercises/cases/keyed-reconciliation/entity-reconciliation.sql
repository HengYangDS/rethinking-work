-- Values are synthetic counts, not returns or portfolio exposures.
WITH expected AS (
  SELECT * FROM read_csv_auto('entity-expected.csv')
), observed AS (
  SELECT * FROM read_csv_auto('entity-observed.csv')
)
SELECT COALESCE(e.entity_id, o.entity_id) AS entity_id,
       e.value AS expected_value, o.value AS observed_value,
       o.value - e.value AS observed_minus_expected
FROM expected e FULL JOIN observed o USING (entity_id)
WHERE e.value IS DISTINCT FROM o.value
ORDER BY entity_id;
