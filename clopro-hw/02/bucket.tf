resource "yandex_iam_service_account" "s3-sa" {
  name        = "s3-service-account"
  description = "Service account for Object Storage management"
}

resource "yandex_resourcemanager_folder_iam_binding" "s3-admin" {
  folder_id = var.yc_folder_id
  role      = "storage.admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.s3-sa.id}"
  ]
}

resource "yandex_iam_service_account_static_access_key" "s3-sa-keys" {
  service_account_id = yandex_iam_service_account.s3-sa.id
  description        = "Static access key for Object Storage"
}

resource "yandex_storage_bucket" "netology-bucket" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.s3-sa-keys.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-sa-keys.secret_key
  acl        = "public-read"
  force_destroy = true
}

resource "yandex_storage_object" "image" {
  bucket     = yandex_storage_bucket.netology-bucket.bucket
  key        = "image.jpg"
  source     = var.image_path
  access_key = yandex_iam_service_account_static_access_key.s3-sa-keys.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-sa-keys.secret_key
  acl        = "public-read"
}
