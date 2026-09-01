-- ============================================================
-- MASTER ANALYTICAL TABLE
-- All variables joined on date, with crisis flags
-- This is what Python will import for SVAR modelling
-- ============================================================

CREATE TABLE master_analytics AS
SELECT
    -- Date key
    op.date,

    -- ── CORE SVAR VARIABLES ──────────────────────────────────
    op.world_crude_prod_mbpd,
    kg.kilian_grea,
    rop.real_oil_price_log,
    iu.inr_usd,
    iu.ln_inr_usd,

    -- ── AUXILIARY VARIABLES ──────────────────────────────────
    bn.brent_nominal_usd,
    uc.us_cpi,
    gi.gpr_global,
    gi.gprt_threats,
    gi.gpra_acts,
    ff.fed_funds_rate,
    fr.forex_reserves_usd_mn,

    -- ── CURRENT ACCOUNT (quarterly → monthly via JOIN) ───────
    -- Each month gets the value of the quarter it belongs to
    cad.india_cad_usd_mn,

    -- ── COMPUTED FLAGS ───────────────────────────────────────
    -- Crisis episode flag (1 = crisis period, 0 = normal)
    CASE
        WHEN op.date BETWEEN '2008-09-01' AND '2009-06-01' THEN 1
        WHEN op.date BETWEEN '2011-01-01' AND '2011-12-01' THEN 1
        WHEN op.date BETWEEN '2020-02-01' AND '2020-09-01' THEN 1
        WHEN op.date BETWEEN '2022-02-01' AND '2022-12-01' THEN 1
        WHEN op.date BETWEEN '2023-10-01' AND '2026-03-01' THEN 1
        ELSE 0
    END AS is_crisis_period,

    -- Episode label for each month
    CASE
        WHEN op.date BETWEEN '2008-09-01' AND '2009-06-01' THEN 'GFC_2008'
        WHEN op.date BETWEEN '2011-01-01' AND '2011-12-01' THEN 'ARAB_SPRING'
        WHEN op.date BETWEEN '2020-02-01' AND '2020-09-01' THEN 'COVID_2020'
        WHEN op.date BETWEEN '2022-02-01' AND '2022-12-01' THEN 'RUSSIA_UKR'
        WHEN op.date BETWEEN '2023-10-01' AND '2024-06-01' THEN 'WEST_ASIA_2023'
        WHEN op.date BETWEEN '2024-07-01' AND '2026-03-01' THEN 'WEST_ASIA_2024'
        ELSE 'NORMAL'
    END AS episode_label,

    -- Shock type classification
    CASE
        WHEN op.date BETWEEN '2008-09-01' AND '2009-06-01' THEN 'Demand Shock'
        WHEN op.date BETWEEN '2011-01-01' AND '2011-12-01' THEN 'Supply Shock'
        WHEN op.date BETWEEN '2020-02-01' AND '2020-09-01' THEN 'Demand Shock'
        WHEN op.date BETWEEN '2022-02-01' AND '2022-12-01' THEN 'Supply Shock'
        WHEN op.date BETWEEN '2023-10-01' AND '2026-03-01' THEN 'Precautionary Demand Shock'
        ELSE 'None'
    END AS shock_type

FROM raw_oil_production op

-- Join all monthly tables on exact date match
JOIN raw_kilian_grea    kg  ON op.date = kg.date
JOIN raw_real_oil_price rop ON op.date = rop.date
JOIN raw_inr_usd        iu  ON op.date = iu.date
JOIN raw_brent_nominal  bn  ON op.date = bn.date
JOIN raw_us_cpi         uc  ON op.date = uc.date
JOIN raw_gpr_index      gi  ON op.date = gi.date
JOIN raw_fed_funds      ff  ON op.date = ff.date
JOIN raw_forex_reserves fr  ON op.date = fr.date

-- Quarterly CAD: match each month to its quarter
-- e.g. 2008-01, 2008-02, 2008-03 all get 2008-Q1 value
LEFT JOIN raw_india_cad cad
    ON cad.date = DATE(CONCAT(
        YEAR(op.date), '-',
        LPAD(((MONTH(op.date)-1) DIV 3)*3+1, 2, '0'),
        '-01'))

ORDER BY op.date;