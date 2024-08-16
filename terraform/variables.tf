variable "project_id" {
    description = "My Project ID"
    default = "your_project_id" # Place your project ID here
}


variable "region" {
    description = "The region in which to provision resources."
    default = "eu-west1"
}


variable "location" {
    description = "The location of the BigQuery dataset."
    default = "EU"
}


variable "bq_dataset_name" {
    description = "My Bigquery Dataset Name"
    default = "ecommerce"
}
