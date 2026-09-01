-- Structural shocks extracted from SVAR
CREATE TABLE svar_structural_shocks (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    date                DATE NOT NULL,
    shock_supply        DECIMAL(12,6),
    shock_demand        DECIMAL(12,6),
    shock_precautionary DECIMAL(12,6),
    episode_label       VARCHAR(50),
    UNIQUE KEY uq_date (date)
);

-- Impulse Response Function results
CREATE TABLE svar_irf_results (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    shock_type    VARCHAR(30) NOT NULL,
    horizon       INT NOT NULL,
    irf_point     DECIMAL(12,6),
    irf_lower_68  DECIMAL(12,6),
    irf_upper_68  DECIMAL(12,6),
    irf_lower_90  DECIMAL(12,6),
    irf_upper_90  DECIMAL(12,6),
    subsample     VARCHAR(20) DEFAULT 'full'
);

-- Forecast Error Variance Decomposition results
CREATE TABLE svar_fevd_results (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    horizon         INT NOT NULL,
    pct_supply      DECIMAL(8,4),
    pct_demand      DECIMAL(8,4),
    pct_precaution  DECIMAL(8,4),
    subsample       VARCHAR(20) DEFAULT 'full'
);