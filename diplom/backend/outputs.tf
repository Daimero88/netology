output "bucket_name" {
  value       = yandex_storage_bucket.terraform_state.bucket
  description = "Name of the created S3 bucket"
}
