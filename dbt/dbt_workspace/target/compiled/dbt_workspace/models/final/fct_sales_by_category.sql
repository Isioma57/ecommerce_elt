select
    product_category_name_english as category,
    total_sales
from
    `capstone-project-430000`.`ecommerce_intermediate`.`int_sales_by_category`
order by
    total_sales desc