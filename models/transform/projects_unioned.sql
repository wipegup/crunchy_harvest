{%- set base_rel = ref('stg_harvest__projects') %}
{%- set client_rel = ref('stg_harvest__projects_client') %}
with
    base as (select * from {{ base_rel}} ),
    clients as (select * from {{ client_rel }} ),
    final as (
        select 
            {{ dbt_utils.star(base_rel, except=get_airbyte_cols(base_rel), relation_alias='base') }},
            client_id 
        from base 
        join clients on clients._airbyte_harvest_projects_hashid = base._airbyte_harvest_projects_hashid
    ),
    clients_stg as (select * from {{ ref('stg_harvest__clients')}})
{# maybe want to rename name as well with prefix? #}

-- select * from final left join clients_stg on clients_stg.client_id = final.client_id where clients_stg.client_id is null
-- SELECT * FROM {{source('raw_harvest', 'harvest_projects')}} WHERE id in (22971527, 28364122) LIMIT 1000
-- One client missing is called "mashey" in harvest details 

select * from final
