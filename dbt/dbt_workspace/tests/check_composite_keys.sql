-- tests/check_composite_keys.sql

select 
    order_id, 
    order_item_id
from 
    {{ ref('stg_order_items')}}
group by 
    order_id, order_item_id
having 
    count(*) > 1