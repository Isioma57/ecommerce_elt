with source as (
select
    product_id,
    product_category_name
from
    `capstone-project-430000`.`ecommerce`.`olist_products`
)

select * from source