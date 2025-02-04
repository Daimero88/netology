output "vm_list" {
  value = flatten([
    for all in [
      yandex_compute_instance.web,
      yandex_compute_instance.db
    ] : [
      for i in all : {
        name = i.name
        id   = i.id
        fqdn = i.fqdn
      }
    ]
  ])
}
