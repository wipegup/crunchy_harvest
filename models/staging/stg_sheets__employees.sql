{%- set rel = source('raw_sheets', 'google_sheets_Sheet1') %}
{%- set except_columns = ['start_date'] + get_airbyte_cols(rel) %}

with src as (select * from {{ rel }})
select {{
    stage_columns(rel, all_upper=false, except=except_columns, 
        modified=[
            rename(adapter.get_columns_in_relation(rel)|map(attribute='name'), except=except_columns, transform='lower')
        ]
    )
}}
PARSE_DATE("%m/%d/%Y", start_date) as start_date
 from src 