
SELECT 
CONCAT(EXTRACT(YEAR FROM r.created_at), '-', EXTRACT(MONTH FROM r.created_at)) as created_month, 
COUNT(DISTINCT(
    CASE WHEN status = 'successful' 
    THEN company_id
    END)) AS company_count,
{% set query %}
        select distinct partner_type from {{ ref('partners') }}
        order by 1
{% endset %}
{% set results = run_query(query) %}
    {% if execute %}
    {% set results_list = results.columns[0].values() %}
    {% else %}
        {% set results_list = [] %}
    {% endif %} 
{% set partnertype = results_list%}
{% for x in partnertype%}
{{ item_rate('partner_type', 'status', 'r.id', 'partners', 'successful', x) }} 
AS {{x}}_referral_successful_rate,
{% endfor%}
FROM {{ ref('referrals') }} AS r
LEFT JOIN {{ ref('partners') }} AS p
    ON r.partner_id = p.id
GROUP BY CONCAT(EXTRACT(YEAR FROM r.created_at), '-', EXTRACT(MONTH FROM r.created_at))
WHERE is_outbound = 1