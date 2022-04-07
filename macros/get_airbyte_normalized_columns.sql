{% macro get_airbyte_normalized_columns(rel) %}
    {%- set to_ex = []%}
    {%- set column_names = [] %}
    {%- for c in adapter.get_columns_in_relation(rel) %}
    {# can use the map filter to get out the name? #}
        {%- do column_names.append((c.name|lower)) %}
    {%- endfor %}

    {%- for r in dbt_utils.get_relations_by_pattern(schema_pattern=rel.schema, table_pattern=rel.identifier~'%')%}
        {%- set c = r.table|replace(rel.identifier~'_', '') %}
        
        {%- if c in column_names %}
            {% do to_ex.append(c) %}
        {%- endif %}
    {%- endfor %}
    {{ return(to_ex) }}
{% endmacro %}