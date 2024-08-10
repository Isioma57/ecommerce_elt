-- tests/check_order_dates.sql

select 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
from 
    {{ ref('stg_orders')}}
where 
    order_purchase_timestamp > order_delivered_customer_date  -- Checks for rows where purchase date is higher than delivery date
