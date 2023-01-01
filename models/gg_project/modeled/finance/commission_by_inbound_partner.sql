SELECT partner_id_inbound, company_id_inbound,  
partner_id_outbound,
min(created_at_outbound) as first_sign_up
FROM {{ ref('complete_sales') }}
GROUP BY company_id_inbound, partner_id_inbound, partner_id_outbound