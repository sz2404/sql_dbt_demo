WITH cte AS (
    SELECT *, 
        ROW_NUMBER() OVER (PARTITION BY 1, 2) AS rank_1
    FROM {{ source('SQL_DBT_demo_source', 'sales_people')}})

SELECT string_field_0 as Name,
string_field_1 as Country
FROM cte
WHERE rank_1 > 1
