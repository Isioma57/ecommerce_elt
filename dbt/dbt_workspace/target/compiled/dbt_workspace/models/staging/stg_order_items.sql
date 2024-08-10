with source as (
select
    order_id,
    order_item_id,
    product_id,
    price
from
    `capstone-project-430000`.`ecommerce`.`olist_order_items`
)

select * from source