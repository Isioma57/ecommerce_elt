

  create or replace view `capstone-project-430000`.`ecommerce_staging`.`stg_orders`
  OPTIONS()
  as with source as (
select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp as date_purchased,
    order_approved_at as payment_approval_date,
    order_delivered_customer_date as date_delivered
from
    `capstone-project-430000`.`ecommerce`.`olist_orders`
)

select * from source;

