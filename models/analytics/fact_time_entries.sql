with src as (select * from {{ ref('time_entries_unioned') }})

select * from src