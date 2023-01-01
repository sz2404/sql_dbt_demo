WITH CTE AS (
    SELECT
        id, 
        DATE(TIMESTAMP_SECONDS(CAST(CAST(created_at/1000000000 AS float64) AS int64))) AS created_at, 
        DATE(TIMESTAMP_SECONDS(CAST(CAST(updated_at/1000000000 AS float64) AS int64))) AS updated_at,
        REPLACE(partner_type, ' ', '_') AS partner_type, 
        lead_sales_contact
    FROM {{ source('SQL_DBT_demo_source', 'partners')}})

SELECT
    id, 
    created_at,
    updated_at,
    partner_type,
    lead_sales_contact
FROM CTE