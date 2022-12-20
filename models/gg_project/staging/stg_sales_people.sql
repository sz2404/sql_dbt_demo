SELECT
* 
FROM {{ source('SQL_DBT_demo_source', 'sales_people')}}