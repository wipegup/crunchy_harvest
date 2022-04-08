{%- set base_rel = ref('client_names_cleaned') %}
{%- set sheet_rel = ref('stg_sheets__customers') %}
{%- set except_base_cols = [] + get_airbyte_cols(base_rel) %}
{%- set except_sheet_cols = ['client']  %}
with base as (select * from {{ base_rel }}),
    sheet as (select * from {{ sheet_rel }})

select 
    {{ dbt_utils.star(base_rel, except=except_base_cols) }},
    {{ dbt_utils.star(sheet_rel, except=except_sheet_cols) }}

from base
left join sheet on base.client_name = sheet.client

order by client_name