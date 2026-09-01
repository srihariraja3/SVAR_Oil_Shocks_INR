-- Create crisis episodes reference table
CREATE TABLE crisis_episodes (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    episode_code   VARCHAR(20)  NOT NULL,
    episode_label  VARCHAR(100) NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE NOT NULL,
    episode_type   VARCHAR(50)  NOT NULL,
    notes          TEXT
);

-- Insert all crisis episodes
INSERT INTO crisis_episodes 
    (episode_code, episode_label, start_date, end_date, episode_type, notes)
VALUES
    ('GFC_2008',
     'Global Financial Crisis',
     '2008-09-01', '2009-06-01',
     'Demand Shock',
     'Lehman collapse Sep 2008. Oil demand collapsed. Classic negative aggregate demand shock.'),

    ('ARAB_SPRING',
     'Arab Spring & Libya Disruption',
     '2011-01-01', '2011-12-01',
     'Supply Shock',
     'Political upheaval across MENA. Libyan production cut by ~1.5 Mb/d. Brent spiked above $120.'),

    ('COVID_2020',
     'COVID-19 Pandemic',
     '2020-02-01', '2020-09-01',
     'Demand Shock',
     'Global demand collapse. Brent fell to ~$18 in Apr 2020. OPEC+ historic production cut agreed.'),

    ('RUSSIA_UKR',
     'Russia-Ukraine War',
     '2022-02-01', '2022-12-01',
     'Supply Shock',
     'Russian invasion Feb 24 2022. Brent spiked to ~$128 in Mar 2022. Major supply disruption.'),

    ('WEST_ASIA_2023',
     'West Asian Crisis - Hamas Attack & Escalation',
     '2023-10-01', '2024-06-01',
     'Precautionary Demand Shock',
     'Hamas attack Oct 7 2023. Houthi Red Sea disruptions from Dec 2023. Precautionary risk premium elevated.'),

    ('WEST_ASIA_2024',
     'West Asian Crisis - Continued Escalation',
     '2024-07-01', '2026-03-01',
     'Precautionary Demand Shock',
     'Continued conflict escalation, Iran-Israel tensions, ongoing Houthi disruptions. INR hit all-time lows past 96.');