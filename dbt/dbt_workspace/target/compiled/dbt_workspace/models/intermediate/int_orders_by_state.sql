with orders_with_state as (
    select
        o.order_id,
        c.customer_state
    from
        `capstone-project-430000`.`ecommerce_staging`.`stg_orders` o
    left join
        `capstone-project-430000`.`ecommerce_staging`.`stg_order_items` oi
    on
        o.order_id = oi.order_id
    left join
        `capstone-project-430000`.`ecommerce_staging`.`stg_customers` c
    on
        o.customer_id = c.customer_id
),

orders_by_state as (
    select
        customer_state as state,
        count(order_id) as number_of_orders
    from
        orders_with_state
    group by
        customer_state
)

select * from orders_by_state