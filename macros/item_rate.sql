{% macro item_rate(item_column, status_column, stats_column, table_name, status_keyword, item_name) %}

ROUND(COUNT( 
    CASE WHEN {{ item_column }} = '{{item_name}}' 
        AND {{ status_column }} = '{{ status_keyword }}'
        THEN {{ stats_column }} 
    END) / 
(COUNT(
    CASE WHEN {{ item_column }} = '{{item_name}}' 
        THEN {{ stats_column }} 
    END) + 0.001), 2)
{% endmacro %}
