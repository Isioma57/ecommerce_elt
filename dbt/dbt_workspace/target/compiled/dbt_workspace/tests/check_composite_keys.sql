-- tests/check_composite_keys.sql

select 
    order_id, 
    order_item_id
from 
    `capstone-project-430000`.`ecommerce_staging`.`stg_order_items`
group by 
    order_id, order_item_id
having 
    count(*) > 1