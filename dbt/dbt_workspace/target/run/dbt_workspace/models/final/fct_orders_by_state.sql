
  
    

    create or replace table `capstone-project-430000`.`ecommerce_final`.`fct_orders_by_state`
      
    
    

    OPTIONS()
    as (
      select
    state,
    number_of_orders
from
    `capstone-project-430000`.`ecommerce_intermediate`.`int_orders_by_state`
    );
  