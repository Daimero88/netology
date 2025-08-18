resource "yandex_iam_service_account" "cicd" {
  name        = "cicd-sa-diplom"
  description = "Service account for CI/CD"
}

resource "yandex_resourcemanager_folder_iam_binding" "pusher" {
  folder_id = var.yc_folder_id
  role      = "container-registry.images.pusher"
  members   = [
    "serviceAccount:${yandex_iam_service_account.cicd.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "puller" {
  folder_id = var.yc_folder_id
  role      = "container-registry.images.puller"
  members   = [
    "serviceAccount:${yandex_iam_service_account.cicd.id}"
  ]
}

resource "yandex_iam_service_account_static_access_key" "cicd-sa-static-key" {
  service_account_id = yandex_iam_service_account.cicd.id
  description        = "Static access key for CI/CD"
}
