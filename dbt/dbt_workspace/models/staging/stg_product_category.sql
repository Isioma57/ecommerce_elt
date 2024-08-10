with source as (
select
    product_category_name,
    product_category_name_english
from
    {{ source('raw', 'product_category') }}
)

select * from source