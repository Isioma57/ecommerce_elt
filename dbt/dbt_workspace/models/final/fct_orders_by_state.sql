select
    state,
    number_of_orders
from
    {{ ref('int_orders_by_state') }}
