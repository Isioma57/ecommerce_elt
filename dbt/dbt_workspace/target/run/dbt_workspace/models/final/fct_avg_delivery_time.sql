
  
    

    create or replace table `capstone-project-430000`.`ecommerce_final`.`fct_avg_delivery_time`
      
    
    

    OPTIONS()
    as (
      select
    order_id,
    avg_delivery_hours,
    avg_delivery_days,
from
    `capstone-project-430000`.`ecommerce_intermediate`.`int_avg_delivery_time`
    );
  