provider "google" {
  project = var.project_id
  region  = var.region
  request_timeout = "90s"
}

# Enable BigQuery API
resource "google_project_service" "bigquery" {
  project = var.project_id
  service = "bigquery.googleapis.com"
}

# Create BigQuery Dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}


# Create BigQuery Tables
resource "google_bigquery_table" "olist_customers" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_customers"
  
  schema = jsonencode([
    {
      "name": "customer_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "customer_unique_id",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "customer_zip_code_prefix",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "customer_city",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "customer_state",
      "type": "STRING",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_geolocation" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_geolocation"
  
  schema = jsonencode([
    {
      "name": "geolocation_zip_code_prefix",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "geolocation_lat",
      "type": "FLOAT",
      "mode": "NULLABLE"
    },
    {
      "name": "geolocation_lng",
      "type": "FLOAT",
      "mode": "NULLABLE"
    },
    {
      "name": "geolocation_city",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "geolocation_state",
      "type": "STRING",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_order_items" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_order_items"

  schema = jsonencode([
    {
      "name": "order_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "order_item_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "product_id",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "seller_id",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "shipping_limit_date",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "price",
      "type": "FLOAT",
      "mode": "NULLABLE"
    },
    {
      "name": "freight_value",
      "type": "FLOAT",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_order_payments" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_order_payments"
  
  schema = jsonencode([
    {
      "name": "order_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "payment_sequential",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "payment_type",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "payment_installments",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "payment_value",
      "type": "FLOAT",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_order_reviews" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_order_reviews"

  schema = jsonencode([
    {
      "name": "review_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "order_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "review_score",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "review_comment_title",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "review_comment_message",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "review_creation_date",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "review_answer_timestamp",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_orders" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_orders"
  
  schema = jsonencode([
    {
      "name": "order_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "customer_id",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "order_status",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "order_purchase_timestamp",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "order_approved_at",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "order_delivered_carrier_date",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "order_delivered_customer_date",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    },
    {
      "name": "order_estimated_delivery_date",
      "type": "TIMESTAMP",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_products" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_products"
  
  schema = jsonencode([
    {
      "name": "product_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "product_category_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "product_name_length",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_description_length",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_photos_qty",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_weight_g",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_length_cm",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_height_cm",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "product_width_cm",
      "type": "INTEGER",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "olist_sellers" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "olist_sellers"
  
  schema = jsonencode([
    {
      "name": "seller_id",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "seller_zip_code_prefix",
      "type": "INTEGER",
      "mode": "NULLABLE"
    },
    {
      "name": "seller_city",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "seller_state",
      "type": "STRING",
      "mode": "NULLABLE"
    }
  ])
}

resource "google_bigquery_table" "product_category" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "product_category"
  
  schema = jsonencode([
    {
      "name": "product_category_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "product_category_name_english",
      "type": "STRING",
      "mode": "NULLABLE"
    }
  ])
}
