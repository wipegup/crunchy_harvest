{%- set rel = ref('users_role_split') %}
{%- set sheet_rel = ref('employee_sheet_fixes') %}
{%- set except_base_cols = ['roles'] + get_airbyte_cols(rel) %}
{%- set except_sheet_cols = ['first_name', 'last_name', 'work_email'] %}
with base as (select * from {{ rel }}),
    sheet as (select * from {{ sheet_rel }})

select 
    {{ dbt_utils.star(rel, except=except_base_cols, relation_alias='base') }},
    {{ dbt_utils.star(sheet_rel, except=except_sheet_cols, relation_alias='sheet') }}

from base
left join sheet on sheet.work_email = base.email