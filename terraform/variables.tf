variable "project_id" {
    description = "My Project ID"
    default = "capstone-project-430000"
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
