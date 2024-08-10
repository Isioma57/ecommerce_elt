with sales as (
select
    o.order_id, 
    product_id, 
    order_item_id, 
    order_status, 
    payment_approval_date, 
    date_delivered, 
    price
from  
    `capstone-project-430000`.`ecommerce_staging`.`stg_orders` o
join 
    `capstone-project-430000`.`ecommerce_staging`.`stg_order_items` oi
on 
    o.order_id = oi.order_id
),

products as (
select 
    p.product_id, 
    pc.product_category_name, 
    pc.product_category_name_english
from 
    `capstone-project-430000`.`ecommerce_staging`.`stg_product_category` pc
join 
    `capstone-project-430000`.`ecommerce_staging`.`stg_products` p
on 
    pc.product_category_name = p.product_category_name
),

total_sales as (
select
    product_category_name_english,
    ROUND(SUM(price),2) AS total_sales
from
    sales as s
join 
    products as p
on 
    s.product_id = p.product_id
group by
    product_category_name_english
)

select * from total_sales