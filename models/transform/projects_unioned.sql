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
    )

{# maybe want to rename name as well with prefix? #}
select * from final
