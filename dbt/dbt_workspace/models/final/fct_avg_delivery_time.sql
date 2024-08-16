select
    ROUND(AVG(avg_delivery_days),1) as avg_delivery_time
from
    {{ ref('int_avg_delivery_time') }}

