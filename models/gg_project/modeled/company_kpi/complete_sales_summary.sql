SELECT
CONCAT(EXTRACT(YEAR FROM updated_at_outbound), '-', EXTRACT(MONTH FROM updated_at_outbound)) as referral_closed_month, 
referral_region_type,
COUNT(
    CASE
        WHEN status_outbound = 'successful' THEN id_inbound
        ELSE NULL
    END) AS sucessful_referral_count,
COUNT(
    CASE
        WHEN status_outbound = 'disinterested' THEN id_inbound
        ELSE NULL
    END) AS disinterested_referral_count, 
COUNT(
    CASE
        WHEN status_outbound = 'pending' THEN id_inbound
        ELSE NULL
    END) AS active_referral_count 
FROM {{ ref('complete_referrals') }}
GROUP BY CONCAT(EXTRACT(YEAR FROM updated_at_outbound), '-', EXTRACT(MONTH FROM updated_at_outbound)), referral_region_type