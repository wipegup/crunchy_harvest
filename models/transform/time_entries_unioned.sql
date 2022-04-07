{%- set base_rel = ref('stg_harvest__time_entries') %}
with
    base as (select * from {{ base_rel}} ),
    users as (select * from {{ ref('stg_harvest__time_entries_user') }} ),
    tasks as (select * from {{ ref('stg_harvest__time_entries_task') }} ),
    task_assignments as (select * from {{ ref('stg_harvest__time_entries_task_assignment') }} ),
    user_assignments as (select * from {{ ref('stg_harvest__time_entries_user_assignment') }} ),
    final as (
        select 
            {{ dbt_utils.star(base_rel, except=get_airbyte_cols(base_rel), relation_alias='base') }},
            user_id,
            task_id,
            task_assignment_id,
            user_assignment_id 
        from base 
        join users on users._airbyte_harvest_time_entries_hashid = base._airbyte_harvest_time_entries_hashid
        join user_assignments on user_assignments._airbyte_harvest_time_entries_hashid = base._airbyte_harvest_time_entries_hashid
        join tasks on tasks._airbyte_harvest_time_entries_hashid = base._airbyte_harvest_time_entries_hashid
        join task_assignments on task_assignments._airbyte_harvest_time_entries_hashid = base._airbyte_harvest_time_entries_hashid
    )
{# Want to test to ensure all tasks, users etc exist in individual tables #}

select * from final
