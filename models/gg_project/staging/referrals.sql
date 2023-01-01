WITH CTE AS (
    SELECT
        id, 
        DATE(TIMESTAMP_SECONDS(CAST(CAST(created_at/1000000000 AS float64) AS int64))) AS created_at, 
        DATE(TIMESTAMP_SECONDS(CAST(CAST(updated_at/1000000000 AS float64) AS int64))) AS updated_at,
        company_id,
        partner_id,
        consultant_id,
        status,
        is_outbound
    FROM {{ source('SQL_DBT_demo_source', 'referrals')}}
    )

SELECT
    id, 
    created_at,
    updated_at,
    DATE_DIFF(updated_at, created_at, DAY) as time_lapse,
    company_id,
    partner_id,
    consultant_id,
    status,
    is_outbound
FROM CTE