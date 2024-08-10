with source as (
select
    product_id,
    product_category_name
from
    {{ source('raw', 'olist_products') }}
)

select * from source