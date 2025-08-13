resource "yandex_container_registry" "this" {
  name = var.ycr_name
}

resource "yandex_container_registry_iam_binding" "public_pull" {
  registry_id = yandex_container_registry.this.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers"
  ]
}
