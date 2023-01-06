/* Commission is based unique referral on the customer's company level.
The query is based on: assuming a unique complete referral is a unique combination of inbound partner, inbound customer company, matching an outbound partner.*/
SELECT partner_id_inbound, company_id_inbound,  
partner_id_outbound, status_outbound as current_status,
min(created_at_outbound) as first_sign_up
FROM {{ ref('complete_referrals') }}
GROUP BY company_id_inbound, partner_id_inbound, partner_id_outbound, status_outbound