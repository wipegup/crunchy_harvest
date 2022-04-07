{%- set rel = ref('users_role_split') %}
{%- set except_cols = ['roles'] + get_airbyte_cols(rel) %}
with src as (select * from {{ rel }})

select {{ dbt_utils.star(rel, except=except_cols) }} from src