resource "yandex_compute_instance" "k8s_nodes" {
  for_each = {
    master1 = { 
      zone = "ru-central1-a", 
      subnet_id = yandex_vpc_subnet.subnet_a.id,
      cores = 2,
      memory = 4,
      core_fraction = 100
    },
    worker1 = { 
      zone = "ru-central1-b", 
      subnet_id = yandex_vpc_subnet.subnet_b.id,
      cores = 2,
      memory = 4,
      core_fraction = 100
    },
    worker2 = { 
      zone = "ru-central1-d", 
      subnet_id = yandex_vpc_subnet.subnet_d.id,
      cores = 2,
      memory = 4,
      core_fraction = 100
    }
  }

  name        = "k8s-${each.key}"
  platform_id = "standard-v2"
  zone        = each.value.zone

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = "fd8e4gcflhhc7odvbuss"
      size     = 30
    }
  }

  network_interface {
    subnet_id = each.value.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = each.key != "master1"
  }
}
