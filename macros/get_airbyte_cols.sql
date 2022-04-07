{% macro get_airbyte_cols(rel, except=[]) %}
    {{ return(get_matching_columns(rel, '_airbyte_.*', except)) }}
{% endmacro %}