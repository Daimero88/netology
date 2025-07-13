resource "yandex_iam_service_account" "vm-sa" {
  name        = "vm-service-account"
  description = "Service account for VM and network access"
}

resource "yandex_resourcemanager_folder_iam_binding" "network-admin" {
  folder_id = var.yc_folder_id
  role      = "vpc.admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "compute-admin" {
  folder_id = var.yc_folder_id
  role      = "compute.admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.vm-sa.id}"
  ]
}
