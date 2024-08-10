with source as (
select
    order_id,
    order_item_id,
    product_id,
    price
from
    {{ source('raw', 'olist_order_items') }}
)

select * from source