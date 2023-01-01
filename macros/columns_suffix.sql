/* Reference: https://discourse.getdbt.com/t/prefix-columns-maco/4235 */

{%- macro columns_suffix(table_name, abbr, suffix) -%}
    {%- set cols = adapter.get_columns_in_relation(ref(table_name)) -%}

    {% for col in cols %}
        {{abbr}}.{{col.name}} as {{col.name}}_{{suffix}},
    {% endfor %}

{%- endmacro -%}