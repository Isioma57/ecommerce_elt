with source as (
select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp as date_purchased,
    order_approved_at as payment_approval_date,
    order_delivered_customer_date as date_delivered
from
    {{ source('raw', 'olist_orders') }}
)

select * from source