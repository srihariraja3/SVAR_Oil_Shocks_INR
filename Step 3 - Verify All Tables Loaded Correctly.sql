-- Check row counts for all tables
-- Every table should show 303 rows (Jan 2000 to Mar 2026)

SELECT 'raw_oil_production'  AS table_name, COUNT(*) AS row_count FROM raw_oil_production
UNION ALL
SELECT 'raw_kilian_grea',    COUNT(*) FROM raw_kilian_grea
UNION ALL
SELECT 'raw_brent_nominal',  COUNT(*) FROM raw_brent_nominal
UNION ALL
SELECT 'raw_us_cpi',         COUNT(*) FROM raw_us_cpi
UNION ALL
SELECT 'raw_real_oil_price', COUNT(*) FROM raw_real_oil_price
UNION ALL
SELECT 'raw_inr_usd',        COUNT(*) FROM raw_inr_usd
UNION ALL
SELECT 'raw_gpr_index',      COUNT(*) FROM raw_gpr_index
UNION ALL
SELECT 'raw_fed_funds',      COUNT(*) FROM raw_fed_funds
UNION ALL
SELECT 'raw_forex_reserves', COUNT(*) FROM raw_forex_reserves
UNION ALL
SELECT 'raw_india_cad',      COUNT(*) FROM raw_india_cad;

SELECT *
FROM raw_fed_funds
ORDER BY date DESC
LIMIT 3;

DELETE FROM raw_fed_funds
WHERE date IN ('2026-04-01', '2026-05-01', '2026-06-01');

DELETE FROM raw_forex_reserves
WHERE date IN ('2026-04-01', '2026-05-01', '2026-06-01');

SELECT
    SUM(CASE WHEN world_crude_prod_mbpd IS NULL THEN 1 ELSE 0 END) AS nulls_prod,
    SUM(CASE WHEN kilian_grea IS NULL THEN 1 ELSE 0 END) AS nulls_grea,
    SUM(CASE WHEN real_oil_price_log IS NULL THEN 1 ELSE 0 END) AS nulls_rp,
    SUM(CASE WHEN ln_inr_usd IS NULL THEN 1 ELSE 0 END) AS nulls_inr,
    SUM(CASE WHEN gpr_global IS NULL THEN 1 ELSE 0 END) AS nulls_gpr,
    SUM(CASE WHEN fed_funds_rate IS NULL THEN 1 ELSE 0 END) AS nulls_fed,
    SUM(CASE WHEN forex_reserves_usd_mn IS NULL THEN 1 ELSE 0 END) AS nulls_forex
FROM raw_oil_production
JOIN raw_kilian_grea    USING (date)
JOIN raw_real_oil_price USING (date)
JOIN raw_inr_usd        USING (date)
JOIN raw_gpr_index      USING (date)
JOIN raw_fed_funds      USING (date)
JOIN raw_forex_reserves USING (date);

SELECT 
    MIN(date) AS first_date,
    MAX(date) AS last_date
FROM raw_oil_production;

SELECT 
    op.date,
    op.world_crude_prod_mbpd,
    kg.kilian_grea,
    rop.real_oil_price_log,
    iu.inr_usd
FROM raw_oil_production op
JOIN raw_kilian_grea    kg  ON op.date = kg.date
JOIN raw_real_oil_price rop ON op.date = rop.date
JOIN raw_inr_usd        iu  ON op.date = iu.date
WHERE op.date IN (
    '2000-01-01',   -- baseline
    '2008-07-01',   -- pre-GFC oil peak
    '2020-04-01',   -- COVID crash
    '2022-03-01',   -- Russia-Ukraine spike
    '2023-10-01',   -- West Asia crisis start
    '2026-03-01'    -- latest
);












