{%- set rel = ref('users_role_split') %}
with src as (select * from {{ rel }})

select {{ dbt_utils.star(rel, except=['roles']) }} from src