with source as (
select
    customer_id,
    customer_state
from
    {{ source('raw', 'olist_customers') }}
)

select * from source