select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- tests/check_order_dates.sql

select 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
from 
    `capstone-project-430000`.`ecommerce_staging`.`stg_orders`
where 
    order_purchase_timestamp > order_delivered_customer_date  -- Checks for rows where purchase date is higher than delivery date
      
    ) dbt_internal_test