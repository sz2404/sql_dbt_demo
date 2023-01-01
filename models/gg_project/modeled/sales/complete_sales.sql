/* This table ables to summarize referrals that came inbound and moved to upsell */
/* It is relatively difficult to match specially when one company has multiple inbound and upsell referral records */
/* Assumptions & methodology used here: 
    Once a company reached successful inbound referral, the query matches it with a upsell referral that has the created date after it's inbound updated date.
    Through ranking the inbound referral updated dates and the outbound referral created dates, the query matches the rank. */

WITH r1 AS (
    SELECT {{ columns_suffix('referrals', 'r1', 'inbound') }}
    p.partner_type AS partner_type_inbound,
    ROW_NUMBER()
    OVER(PARTITION BY company_id ORDER BY r1.updated_at) AS inbound_rk 
    FROM {{ ref('referrals') }} AS r1
    LEFT JOIN {{ ref('partners') }} AS p
        ON r1.partner_id = p.id
    WHERE r1.is_outbound = 0 and r1.status = 'successful'
    ),
    r2 AS (
    SELECT {{ columns_suffix('referrals', 'r2', 'outbound') }}
    p.partner_type as partner_type_outbound,
    ROW_NUMBER()
    OVER(PARTITION BY company_id ORDER BY r2.updated_at) AS outbound_rk 
    FROM {{ ref('referrals') }} AS r2
    LEFT JOIN {{ ref('partners') }} AS p
        ON r2.partner_id = p.id
    WHERE r2.is_outbound = 1
    )


SELECT 
id_inbound,
created_at_inbound, updated_at_inbound,
company_id_inbound, partner_id_inbound, partner_type_inbound, consultant_id_inbound,
id_outbound,
created_at_outbound, updated_at_outbound,
partner_id_outbound, partner_type_outbound, consultant_id_outbound,
status_outbound
FROM r1
LEFT JOIN r2
ON r1.company_id_inbound = r2.company_id_outbound
AND r1.inbound_rk = r2.outbound_rk
WHERE r2.created_at_outbound >= r1.updated_at_inbound