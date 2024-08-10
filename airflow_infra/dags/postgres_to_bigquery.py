from airflow import DAG
from airflow.decorators import task, dag
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.google.cloud.hooks.bigquery import BigQueryHook
from datetime import datetime, timedelta
from dotenv import load_dotenv
import pandas as pd
import os
from google.cloud import bigquery

# Load environment variables from .env file
load_dotenv('/opt/airflow/config/.env')

# Define Default Arguments
default_args = {
    'owner': 'isioma',
    'start_date': datetime(2024, 8, 4),
    'retries': 5,
    'retry_delay': timedelta(minutes=2),
}

# List of tables to transfer (PostgreSQL table name, BigQuery table name)
tables = [
    ('raw.olist_customers', 'olist_customers'),
    ('raw.olist_geolocation', 'olist_geolocation'),
    ('raw.olist_order_items', 'olist_order_items'),
    ('raw.olist_order_payments', 'olist_order_payments'),
    ('raw.olist_order_reviews', 'olist_order_reviews'),
    ('raw.olist_orders', 'olist_orders'),
    ('raw.olist_products', 'olist_products'),
    ('raw.olist_sellers', 'olist_sellers'),
    ('raw.product_category', 'product_category'),
]

@dag(
    default_args=default_args,
    description='Load data from PostgreSQL to Google BigQuery',
    schedule_interval='@daily',
    catchup=False
)
def postgres_to_bigquery_dataflow():
    
    
    @task
    def create_intermediate_schema():
        """
        Create the intermediate schema if it doesn't exist.
        """
        postgres_hook = PostgresHook(postgres_conn_id='postgres_conn')
        create_schema_sql = "CREATE SCHEMA IF NOT EXISTS intermediate;"
        postgres_hook.run(create_schema_sql)
        print("Schema 'intermediate' created or already exists.")


    @task
    def extract_data_from_postgres(tables):
        """
        Extract data from PostgreSQL and save to an intermediate PostgreSQL table.

        Parameters:
        - tables: List of tuples with PostgreSQL and BigQuery table names.
        """
        postgres_hook = PostgresHook(postgres_conn_id='postgres_conn')

        for postgres_table, bigquery_table in tables:
            # SQL command to copy data from the source table to an intermediate table
            sql = f"SELECT * INTO intermediate.{bigquery_table} FROM {postgres_table}"
            postgres_hook.run(sql)

    @task
    def load_data_to_bigquery(dataset_id, tables):
        """
        Load data from intermediate PostgreSQL tables to BigQuery.

        Parameters:
        - dataset_id: The ID of the BigQuery dataset.
        - tables: List of tuples with PostgreSQL and BigQuery table names.
        """
        client = BigQueryHook(gcp_conn_id='gcp_bigquery').get_client()

        for _, bigquery_table in tables:
            table_id = f"{dataset_id}.{bigquery_table}"

            # Load data from intermediate table in PostgreSQL to BigQuery
            sql = f"SELECT * FROM intermediate.{bigquery_table}"
            df = PostgresHook(postgres_conn_id='postgres_conn').get_pandas_df(sql)
            
            # Fetch the schema from the existing BigQuery table
            table = client.get_table(table_id)
            schema = table.schema

            job_config = bigquery.LoadJobConfig(
                schema=schema,  # Use existing table schema
                write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,  # Overwrite the table with new data
            )

            # Load the data from the DataFrame into BigQuery
            job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
            job.result()  # Wait for the job to complete
            print(f"Loaded data into {dataset_id}:{bigquery_table}")

    # Define tasks
    create_schema_task = create_intermediate_schema()
    data_from_postgres = extract_data_from_postgres(tables)
    load_data_task = load_data_to_bigquery(os.getenv('GCP_PROJECT_ID') + '.ecommerce', tables)

    # Set task dependencies
    create_schema_task >> data_from_postgres >> load_data_task

# Instantiate the DAG
postgres_to_bigquery_dataflow_dag = postgres_to_bigquery_dataflow()
