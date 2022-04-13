{%- set base_rel = ref('stg_harvest__time_entries') %}
{%- set join_tables = ['user', 'task', 'task_assignment', 'user_assignment', 'client', 'project'] %}
with
    base as (select * from {{ base_rel}} ),
    {%- for table in join_tables %}
        {{ table }}s AS (select * from {{ ref('stg_harvest__time_entries_'~table) }} ),
    {%- endfor %}
    final as (
        select 
            {{ dbt_utils.star(base_rel, except=get_airbyte_cols(base_rel), relation_alias='base') }},
            {%- for table in join_tables %}
                {{table}}_id{% if not loop.last %},{% endif %}
            {%- endfor %}
        from base 
        {%- for table in join_tables %}
            join {{table}}s on {{table}}s._airbyte_harvest_time_entries_hashid = base._airbyte_harvest_time_entries_hashid
        {%- endfor %}
        
    )
{# Want to test to ensure all tasks, users etc exist in individual tables #}

select * from final
