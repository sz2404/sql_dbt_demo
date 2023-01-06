WITH CTE AS (
    SELECT r.*, 
    CONCAT(EXTRACT(YEAR FROM r.updated_at), '-', EXTRACT(MONTH FROM r.updated_at)) AS deal_closed_month,
    p.partner_type,
    CASE
        WHEN is_outbound = 0 THEN 'Inbound'
        ELSE 'Outbound'
    END AS sales_type,
    sp.Country
    FROM {{ ref('referrals') }} AS r
    LEFT JOIN {{ ref('partners') }} AS p
        ON r.partner_id = p.id
    LEFT JOIN {{ ref('sales_people') }} as sp
        ON sp.NAME = p.lead_sales_contact
)
SELECT 
Country,
deal_closed_month,
sales_type,
status, 
partner_type,
COUNT(id) AS referral_count,
ROUND(AVG(time_lapse), 2) AS status_change_days
FROM CTE
WHERE status IN ('successful', 'disinterested')
GROUP BY Country, deal_closed_month, sales_type, status, partner_type