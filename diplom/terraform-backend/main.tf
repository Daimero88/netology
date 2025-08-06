terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.85.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
}

resource "yandex_iam_service_account" "tf-sa" {
  name        = "tf-sa"
  description = "Service account for Terraform"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.tf-sa.id}"
  ]
}

resource "yandex_storage_bucket" "tf-state" {
  bucket = "ssilchin-diplom"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.tf-sa.id
  description        = "Static access key for S3"
}

resource "yandex_storage_bucket_iam_binding" "binding" {
  bucket = yandex_storage_bucket.tf-state.id
  role   = "storage.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.tf-sa.id}"
  ]
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}
