with src as (select * from {{ ref('invoice_line_items_unioned') }})

select * from src