-- Must return 315 rows
SELECT COUNT(*) FROM master_analytics;

-- Check episode distribution
SELECT 
    episode_label,
    shock_type,
    COUNT(*) AS months
FROM master_analytics
GROUP BY episode_label, shock_type
ORDER BY MIN(date);