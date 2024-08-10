select
    order_id,
    avg_delivery_hours,
    avg_delivery_days,
from
    {{ ref('int_avg_delivery_time') }}

