select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customer_state
from `capstone-project-430000`.`ecommerce`.`olist_customers`
where customer_state is null



      
    ) dbt_internal_test