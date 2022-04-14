{%- set rel = ref('stg_sheets__employees') %}
with src as (select * from {{ rel }} )

select 
    {{ dbt_utils.star(rel, except=['start_date', 'work_email']) }},
    CASE 
        WHEN EXTRACT(YEAR FROM start_date) < 100 THEN DATE_ADD(start_date, INTERVAL 2000 YEAR)
        ELSE start_date 
    END AS start_date,
    CASE 
        WHEN work_email = 'david@mashey.com' THEN 'daveh@mashey.com'
        ELSE work_email
    END AS work_email
from src