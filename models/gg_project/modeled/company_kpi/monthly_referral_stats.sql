WITH CTE AS (
    SELECT r.*, 
    CONCAT(EXTRACT(YEAR FROM r.created_at), '-', EXTRACT(MONTH FROM r.created_at)) as created_month,
    p.created_at as partner_created_at, 
    p.partner_type, 
    CASE
        WHEN is_outbound = 0 THEN 'Inbound'
        ELSE 'Outbound'
    END AS sales_type,
    p.lead_sales_contact
    FROM {{ ref('referrals') }} AS r
    LEFT JOIN {{ ref('partners') }} AS p
        ON r.partner_id = p.id
)
SELECT 
created_month,
partner_type,
sales_type,
status, 
COUNT(id) AS referral_created_count,
SUM(COUNT(id)) 
    OVER(ORDER BY created_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_referral_count,
ROUND(AVG(time_lapse), 2) AS status_change_days,
AVG(ROUND(AVG(time_lapse), 2)) 
    OVER(ORDER BY created_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS status_change_days_trailing_12_months
FROM CTE
GROUP BY created_month, partner_type, sales_type, status