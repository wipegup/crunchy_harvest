{% macro get_date_columns(rel, except=[]) %}
    {%- set column_names = [] %}
    {%- set date_columns = [] %}
    {%- for c in adapter.get_columns_in_relation(rel) %}
        {%- do column_names.append((c.name|lower)) %}
    {%- endfor %}
    {%- set re = modules.re %}
    {%- set patt = '.*_date' %}
    {%- for c in column_names %}
    
        {%- if re.match(patt, c) and c not in except %} {% do date_columns.append(c) %} {%- endif %}
    {%- endfor %}

    {{ return(date_columns)}}
{% endmacro %}