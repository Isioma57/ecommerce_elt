# E-Commerce Data Transformations with dbt

This dbt project is part of an end-to-end ETL pipeline for analyzing a Brazilian E-Commerce dataset. The project includes staging, intermediate, and final models that transform the raw data into insights about sales, delivery times, and order distributions.

# Project Structure
### staging/: 
Contains staging models that load raw data from the source and prepare it for transformation.

  - stg_customers.sql: Cleans and prepares the customers data.

  - stg_orders.sql: Cleans and prepares the orders data.

  - stg_order_items.sql: Cleans and prepares the order items data.

  - stg_products.sql: Cleans and prepares the products data.

  - stg_products_category.sql: Cleans and prepares the product categories data.

  - source.yml: Defines the sources and sets up tests for the raw data.

### intermediate/: 
Intermediate models that perform complex transformations or aggregations.

  - int_sales_by_category.sql: Aggregates sales data by product category.

  - int_orders_by_state.sql: Counts the number of orders per state.

  - int_avg_delivery_time.sql: Calculates the average delivery time for orders.

### final/: 
Final models that provide the datasets ready for analysis.

  - fct_sales_by_category.sql: Final table showing total sales by category.

   - fct_orders_by_state.sql: Final table showing the number of orders per state.

   - fct_avg_delivery_time.sql: Final table showing the average delivery time in days.

### tests/: 
Contains SQL-based tests for data quality checks.

  - check_composite_keys.sql: Ensures uniqueness of composite keys in order items.

  - check_order_dates.sql: Validates that order purchase dates are before delivery dates.

# Model Explanation

## Staging Models
  - stg_customers.sql: This model loads and cleans raw customer data, ensuring that all necessary fields are present and correctly formatted.

  - stg_orders.sql: This model prepares the orders data by transforming timestamps and filtering necessary columns.

  - stg_order_items.sql: This model joins order items with orders to provide detailed order-level insights.

  - stg_products.sql: This model links product data with categories.

  - stg_products_category.sql: This model maps product categories to their English names.

## Intermediate Models

  - int_sales_by_category.sql: Aggregates total sales for each product category by joining orders with order items and products.

  ```sql
  with sales as (
select
    o.order_id, 
    product_id, 
    order_item_id, 
    order_status, 
    payment_approval_date, 
    date_delivered, 
    price
from  
    {{ ref('stg_orders') }} o
join 
    {{ ref('stg_order_items') }} oi
on 
    o.order_id = oi.order_id
),

products as (
select 
    p.product_id, 
    pc.product_category_name, 
    pc.product_category_name_english
from 
    {{ ref('stg_product_category') }} pc
join 
    {{ ref('stg_products') }} p
on 
    pc.product_category_name = p.product_category_name
),

total_sales as (
select
    product_category_name_english,
    ROUND(SUM(price),2) AS total_sales
from
    sales as s
join 
    products as p
on 
    s.product_id = p.product_id
group by
    product_category_name_english
)

select * from total_sales
  ```

  - int_orders_by_state.sql: Counts the number of orders in each state, regardless of order status, to identify the regional distribution of sales.
```sql
with orders_with_state as (
    select
        o.order_id,
        c.customer_state
    from
        {{ ref('stg_orders') }} o
    left join
        {{ ref('stg_order_items') }} oi
    on
        o.order_id = oi.order_id
    left join
        {{ ref('stg_customers') }} c
    on
        o.customer_id = c.customer_id
),

orders_by_state as (
    select
        customer_state as state,
        count(order_id) as number_of_orders
    from
        orders_with_state
    group by
        customer_state
)

select * from orders_by_state
```
  - int_avg_delivery_time.sql: Calculates the average delivery time by comparing order purchase and delivery dates.
```sql
with orders as (
    select
        o.order_id,
        oi.order_item_id,
        o.order_status,
        date_purchased,
        date_delivered
    from
        {{ ref('stg_orders') }} o
    join
        {{ ref('stg_order_items') }} oi
    on 
        o.order_id = oi.order_id
    where
        o.order_status = 'delivered'
        and date_delivered is not null
),

delivery_time as (
    select
        order_id,
        order_item_id,
        DATE_DIFF(DATE(date_delivered), DATE(date_purchased), DAY) as delivery_days
    from
        orders
),

order_avg_delivery_time as (
    select
        order_id,
        AVG(delivery_days) as avg_delivery_days
    from
        delivery_time
    group by
        order_id
),

avg_delivery_time as(
select 
    dt.order_id,
    oadt.avg_delivery_days
from 
    delivery_time dt
join 
    order_avg_delivery_time oadt
on 
    dt.order_id = oadt.order_id
)

select * from avg_delivery_time
```
## Final Models
  - fct_sales_by_category.sql: Provides a clean, final table with total sales per product category.
```sql
select
    product_category_name_english as category,
    total_sales
from
    {{ ref('int_sales_by_category') }}
order by
    total_sales desc
```
  - fct_orders_by_state.sql: Final table listing the number of orders per state.
```sql
select
    state,
    number_of_orders
from
    {{ ref('int_orders_by_state') }}
```
  - fct_avg_delivery_time.sql: Final model showing average delivery time, providing insights into logistical efficiency.
  
```sql
select
    ROUND(AVG(avg_delivery_days),1) as avg_delivery_time
from
    {{ ref('int_avg_delivery_time') }}
```

# Running the Models
To run all the models in this dbt project, navigate to the root directory of the dbt project ie dbt_workspace and execute:

```bash
dbt run
```
This will execute all models, starting with staging, followed by intermediate, and finally the final models.

# Running Tests
To ensure data integrity and quality, run the tests:

```bash
dbt test
```
This will execute the tests defined in your source.yml and the custom SQL tests in the tests/ directory.

# Troubleshooting
If you encounter any issues, you can:
  - check the logs of the dbt using:
```bash
dbt logs
```
This command will display the logs and help you identify any issues during model execution.
  - check the dbt log file within the project directory.

# Report
The report on this analysis was done using looker studio. You can check it out [here](https://lookerstudio.google.com/s/kb4dPZfyZnQ).