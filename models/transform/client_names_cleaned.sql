{%- set rel = ref('stg_harvest__clients') %}
{%- set client_programs = {'Looker Jumpstart: ': 'Looker Jumpstart', 'Looker SOW - ': 'Looker SOW'} %}
{%- set client_renames = {
    'Integrated Financial Settlements Inc.  (IFS)': 'IFS',
    'Camp': 'Camp.com',
    'Looker Jumpstart: Camp': 'Camp.com',
    'Cella (fka BLR Holdings)': 'Cella',
    'Ceresa, Inc.': 'Ceresa',
    'DAZ3D': 'DAZ 3D',
    'Looker Jumpstart: DAZ3D': 'DAZ 3D',
    'Dandelion Chocolates':'Dandelion Chocolate',
    'Looker SOW - Dandelion Chocolates':'Dandelion Chocolate',
    'Fivos Health':'Fivos',
    'GlassGuru': 'Glass Guru',
    'Monica & Andy': 'Monica + Andy',
    'PGA of America': 'PGA of Americas',
    'PaybyPhone':'PayByPhone',
    'Looker Jumpstart: PaybyPhone':'PayByPhone',
    'Verano Holdings': 'Verano',
    'Looker Jumpstart: Verano Holdings': 'Verano',
    'Zenni Optical': 'Zenni'
    } %}
with src as (select * from {{ rel }})


select 
CASE
{%- for k,v in client_renames.items() %}
    WHEN client_name = '{{k}}' THEN '{{v}}'
{%- endfor %}
{%- for k, v in client_programs.items() %}
    WHEN STARTS_WITH(client_name, '{{k}}') THEN REPLACE(client_name, '{{k}}', '')
{%- endfor %}
    ELSE client_name
END as client_name,
CASE
{%- for k, v in client_programs.items() %}
    WHEN STARTS_WITH(client_name, '{{k}}') THEN '{{v}}'
{%- endfor %}
    ELSE NULL
END as client_program,
{{ dbt_utils.star(rel, except=['client_name']) }}

 from src