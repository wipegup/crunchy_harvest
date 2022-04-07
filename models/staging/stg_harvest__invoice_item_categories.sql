{%- set rel = source('raw_harvest', 'harvest_invoice_item_categories') %}
{%- set except_columns = [] + get_airbyte_normalized_columns(rel) + airbyte_ingest_columns() %}
{%- set date_columns = [] + get_date_columns(rel, except=[]) %}

with src as (select * from {{ rel }})

select {{
    stage_columns(rel, all_upper=false, except=except_columns, 
        modified=[
            cast('date', date_columns)
        ]
    )
}} from src