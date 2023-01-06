{% test sales_lead_inlusion(model, column_name) %}
WITH validation AS (
    SELECT DISTINCT column_name as missing_sales_people
    FROM {{ model }}
    WHERE column_name not in 
    (SELECT Name FROM {{ ref('sales_people')}}
),

validation_errors as (
    SELECT missing_sales_people
    FROM validation
)

SELECT * 
FROM validation_errors
{% endtest %}