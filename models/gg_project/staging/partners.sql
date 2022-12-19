WITH CTE AS (
    SELECT
        id, 
        CAST(created_at/1000000000 AS float64) AS nc, 
        CAST(updated_at/1000000000 AS float64) AS nu,
        partner_type,
        lead_sales_contact
    FROM {{ source('SQL_DBT_demo', 'partner')}})

SELECT
    id, 
    DATE(TIMESTAMP_SECONDS(cast(nc as int64))) as created_at,
    DATE(TIMESTAMP_SECONDS(cast(nu as int64))) as updated_at,
    partner_type,
    lead_sales_contact
FROM CTE