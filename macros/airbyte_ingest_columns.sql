{% macro airbyte_ingest_columns() %}
    {{ return(['_airbyte_ab_id', '_airbyte_emitted_at', '_airbyte_normalized_at']) }}
{% endmacro %}