select
    product_category_name_english as category,
    total_sales
from
    {{ ref('int_sales_by_category') }}
order by
    total_sales desc
