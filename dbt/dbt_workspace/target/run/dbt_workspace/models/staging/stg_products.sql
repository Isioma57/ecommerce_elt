

  create or replace view `capstone-project-430000`.`ecommerce_staging`.`stg_products`
  OPTIONS()
  as with source as (
select
    product_id,
    product_category_name
from
    `capstone-project-430000`.`ecommerce`.`olist_products`
)

select * from source;

