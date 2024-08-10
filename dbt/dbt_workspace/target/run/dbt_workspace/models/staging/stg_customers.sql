

  create or replace view `capstone-project-430000`.`ecommerce_staging`.`stg_customers`
  OPTIONS()
  as with source as (
select
    customer_id,
    customer_state
from
    `capstone-project-430000`.`ecommerce`.`olist_customers`
)

select * from source;

