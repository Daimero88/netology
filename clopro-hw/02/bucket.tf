resource "yandex_iam_service_account" "sa" {
  name = "bucket-sa-ssilchin"
}

resource "yandex_resourcemanager_folder_iam_binding" "binding" {
  folder_id = var.yc_folder_id
  role      = "storage.editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

resource "yandex_iam_service_account_static_access_key" "sa-key" {
  service_account_id = yandex_iam_service_account.sa.id
}

resource "yandex_storage_bucket" "netology-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-key.secret_key
  bucket     = var.bucket_name
  acl        = "public-read"
}

resource "yandex_storage_object" "image" {
  access_key = yandex_iam_service_account_static_access_key.sa-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-key.secret_key
  bucket     = yandex_storage_bucket.netology-bucket.bucket
  key        = "image.jpg"
  source     = var.image_path
  acl        = "public-read"
}
