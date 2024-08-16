with orders as (
    select
        o.order_id,
        oi.order_item_id,
        o.order_status,
        date_purchased,
        date_delivered
    from
        {{ ref('stg_orders') }} o
    join
        {{ ref('stg_order_items') }} oi
    on 
        o.order_id = oi.order_id
    where
        o.order_status = 'delivered'
        and date_delivered is not null
),

delivery_time as (
    select
        order_id,
        order_item_id,
        DATE_DIFF(DATE(date_delivered), DATE(date_purchased), DAY) as delivery_days
    from
        orders
),

order_avg_delivery_time as (
    select
        order_id,
        AVG(delivery_days) as avg_delivery_days
    from
        delivery_time
    group by
        order_id
),

avg_delivery_time as(
select 
    dt.order_id,
    oadt.avg_delivery_days
from 
    delivery_time dt
join 
    order_avg_delivery_time oadt
on 
    dt.order_id = oadt.order_id
)

select * from avg_delivery_time