{%- set base_rel = ref('stg_harvest__invoices_line_items') %}
{%- set invoices_rel = ref('stg_harvest__invoices') %}

with
    base as (select * from {{ base_rel}} ),
    invoices as (select * from {{ invoices_rel }} ),
    client as (select * from {{ ref('stg_harvest__invoices_client') }} ),
    creator as (select * from {{ ref('stg_harvest__invoices_creator') }} ),
    project as (select * from {{ ref('stg_harvest__invoices_line_items_project') }} ),
    final as (
        select 
            {{ dbt_utils.star(base_rel, except=get_airbyte_cols(base_rel), relation_alias='base') }},
            {{ dbt_utils.star(invoices_rel, except=get_airbyte_cols(invoices_rel), relation_alias='invoices') }},
            creator_id,
            client_id,
            project_id
        from base 
        join invoices on invoices._airbyte_harvest_invoices_hashid = base._airbyte_harvest_invoices_hashid
        join client on client._airbyte_harvest_invoices_hashid = base._airbyte_harvest_invoices_hashid
        join creator on creator._airbyte_harvest_invoices_hashid = base._airbyte_harvest_invoices_hashid
        join project on project._airbyte_line_items_hashid = base._airbyte_line_items_hashid
    )
{# need_tests? for client, creator and project? #}

select * from final
