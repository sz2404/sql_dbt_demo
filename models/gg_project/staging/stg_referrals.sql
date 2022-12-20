WITH CTE AS (
    SELECT
        id, 
        CAST(created_at/1000000000 AS float64) AS nc, 
        CAST(updated_at/1000000000 AS float64) AS nu,
        company_id,
        partner_id,
        consultant_id,
        status,
        is_outbound
    FROM {{ source('SQL_DBT_demo_source', 'referrals')}}
    )

SELECT
    id, 
    DATE(TIMESTAMP_SECONDS(cast(nc as int64))) as created_at,
    DATE(TIMESTAMP_SECONDS(cast(nu as int64))) as updated_at,
    company_id,
    partner_id,
    consultant_id,
    status,
    is_outbound
FROM CTE