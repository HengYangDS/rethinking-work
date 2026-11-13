-- Synthetic decision: preserve all six securities and historical information.
CREATE TABLE candidates AS
SELECT * FROM read_csv_auto('source-candidates.csv');

-- Hard requirements precede comparison of onboarding effort.
CREATE VIEW selected AS
SELECT * FROM candidates
WHERE purpose = 'historical_decision'
  AND universe = 'U6'
  AND period_start = DATE '2024-01-01'
  AND period_end = DATE '2024-12-31'
  AND use_allowed
  AND required_securities = 6
  AND covered_securities = required_securities
  AND has_revision_history
  AND has_available_time
ORDER BY onboarding_days, source_id
LIMIT 1;
