{%- set rel = ref('stg_harvest__tasks') %}
{%- set except_cols = [] + get_airbyte_cols(rel) %}
with src as (select * from {{ rel }})

select {{ dbt_utils.star(rel, except=except_cols) }} from src