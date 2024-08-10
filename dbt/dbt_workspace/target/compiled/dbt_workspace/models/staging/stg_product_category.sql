with source as (
select
    product_category_name,
    product_category_name_english
from
    `capstone-project-430000`.`ecommerce`.`product_category`
)

select * from source