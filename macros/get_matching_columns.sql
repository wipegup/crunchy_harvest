{% macro get_matching_columns(rel, patt, except=[]) %}
    {%- set column_names = [] %}
    {%- set matching_columns = [] %}
    {%- for c in adapter.get_columns_in_relation(rel) %}
        {%- do column_names.append((c.name|lower)) %}
    {%- endfor %}
    {%- set re = modules.re %}
    {%- for c in column_names %}
    
        {%- if re.match(patt, c) and c not in except %} {% do matching_columns.append(c) %} {%- endif %}
    {%- endfor %}

    {{ return(matching_columns)}}
{% endmacro %}