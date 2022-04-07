{% macro get_date_columns(rel, except=[]) %}
    {{ return(get_matching_columns(rel, '.*_date', except))}}
{% endmacro %}