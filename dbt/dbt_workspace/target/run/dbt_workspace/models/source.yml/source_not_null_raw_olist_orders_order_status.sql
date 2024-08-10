select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select order_status
from `capstone-project-430000`.`ecommerce`.`olist_orders`
where order_status is null



      
    ) dbt_internal_test