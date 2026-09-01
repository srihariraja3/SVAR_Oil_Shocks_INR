CREATE DATABASE IF NOT EXISTS svar_oil_inr
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE svar_oil_inr;

CREATE TABLE raw_oil_production (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    date          DATE NOT NULL,
    world_crude_prod_mbpd DECIMAL(8,3) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_kilian_grea (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    date          DATE NOT NULL,
    kilian_grea   DECIMAL(10,5) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_brent_nominal (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    date               DATE NOT NULL,
    brent_nominal_usd  DECIMAL(8,3) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_us_cpi (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    date      DATE NOT NULL,
    us_cpi    DECIMAL(8,3) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_real_oil_price (
    id                   INT AUTO_INCREMENT PRIMARY KEY,
    date                 DATE NOT NULL,
    brent_nominal_usd    DECIMAL(8,3) NOT NULL,
    us_cpi               DECIMAL(8,3) NOT NULL,
    real_oil_price_log   DECIMAL(10,6) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_inr_usd (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    date        DATE NOT NULL,
    inr_usd     DECIMAL(8,4) NOT NULL,
    ln_inr_usd  DECIMAL(10,6) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_gpr_index (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    date          DATE NOT NULL,
    gpr_global    DECIMAL(10,4) NOT NULL,
    gprt_threats  DECIMAL(10,4) NOT NULL,
    gpra_acts     DECIMAL(10,4) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_fed_funds (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    date            DATE NOT NULL,
    fed_funds_rate  DECIMAL(6,4) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_forex_reserves (
    id                    INT AUTO_INCREMENT PRIMARY KEY,
    date                  DATE NOT NULL,
    forex_reserves_usd_mn DECIMAL(12,2) NOT NULL,
    UNIQUE KEY uq_date (date)
);

CREATE TABLE raw_india_cad (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    date              DATE NOT NULL,
    india_cad_usd_mn  DECIMAL(12,3) NOT NULL,
    UNIQUE KEY uq_date (date)
);