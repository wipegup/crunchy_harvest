{%- set rel = ref('user_info_join') %}
with base as (select * from {{ rel }})

select 
    *
from base
qualify row_number() over (partition by email order by start_date desc) =1 
order by email
