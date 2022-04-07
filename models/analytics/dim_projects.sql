with src as (select * from {{ ref('projects_unioned') }})

select * from src