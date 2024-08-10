

  create or replace view `capstone-project-430000`.`ecommerce_staging`.`stg_product_category`
  OPTIONS()
  as with source as (
select
    product_category_name,
    product_category_name_english
from
    `capstone-project-430000`.`ecommerce`.`product_category`
)

select * from source;

