-- Create Schema
CREATE SCHEMA IF NOT EXISTS RAW;

-- Create and populate tables


-- customers
CREATE TABLE IF NOT EXISTS raw.olist_customers
(
    customer_id VARCHAR,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR,
    customer_state VARCHAR
);

COPY raw.olist_customers
(
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
FROM '/data/olist_customers.csv' DELIMITER ',' CSV HEADER;


-- geolocation
CREATE TABLE IF NOT EXISTS raw.olist_geolocation
(
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

COPY raw.olist_geolocation
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
)
FROM '/data/olist_geolocation.csv' DELIMITER ',' CSV HEADER;


-- order items
CREATE TABLE IF NOT EXISTS raw.olist_order_items
(
    order_id VARCHAR,
    order_item_id INTEGER,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT
);

COPY raw.olist_order_items
(
    order_id ,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
FROM '/data/olist_order_items.csv' DELIMITER ',' CSV HEADER;


-- order payments
CREATE TABLE IF NOT EXISTS raw.olist_order_payments
(
    order_id VARCHAR,
    payment_sequential INTEGER,
    payment_type VARCHAR,
    payment_installments INTEGER,
    payment_value FLOAT
);

COPY raw.olist_order_payments
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
FROM '/data/olist_order_payments.csv' DELIMITER ',' CSV HEADER;


-- reviews
CREATE TABLE IF NOT EXISTS raw.olist_order_reviews
(
    review_id VARCHAR,
    order_id VARCHAR,
    review_score INTEGER,
    review_comment_title VARCHAR,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

COPY raw.olist_order_reviews
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
FROM '/data/olist_order_reviews.csv' DELIMITER ',' CSV HEADER;


-- orders
CREATE TABLE IF NOT EXISTS raw.olist_orders
(
    order_id VARCHAR,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

COPY raw.olist_orders
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
FROM '/data/olist_orders.csv' DELIMITER ',' CSV HEADER;


-- products
CREATE TABLE IF NOT EXISTS raw.olist_products
(
    product_id VARCHAR,
    product_category_name VARCHAR,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

COPY raw.olist_products
(
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
FROM '/data/olist_products.csv' DELIMITER ',' CSV HEADER;


-- sellers
CREATE TABLE IF NOT EXISTS raw.olist_sellers
(
    seller_id VARCHAR,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR,
    seller_state VARCHAR
);

COPY raw.olist_sellers
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
FROM '/data/olist_sellers.csv' DELIMITER ',' CSV HEADER;


-- product category
CREATE TABLE IF NOT EXISTS raw.product_category
(
    product_category_name VARCHAR,
    product_category_name_english VARCHAR
);

COPY raw.product_category
(
    product_category_name,
    product_category_name_english
)
FROM '/data/product_category.csv' DELIMITER ',' CSV HEADER;