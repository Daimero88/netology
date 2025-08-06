terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.85.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

data "yandex_vpc_subnet" "subnet_a" {
  name = "subnet-a"
}

data "yandex_vpc_subnet" "subnet_b" {
  name = "subnet-b"
}

data "yandex_vpc_subnet" "subnet_d" {
  name = "subnet-d"
}

resource "yandex_compute_instance" "k8s_nodes" {
  for_each = {
    master1 = { zone = "ru-central1-a", subnet_id = data.yandex_vpc_subnet.subnet_a.id }
    worker1 = { zone = "ru-central1-b", subnet_id = data.yandex_vpc_subnet.subnet_b.id }
    worker2 = { zone = "ru-central1-d", subnet_id = data.yandex_vpc_subnet.subnet_d.id }
  }

  name        = "k8s-${each.key}"
  platform_id = "standard-v2"
  zone        = each.value.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 30
    }
  }

  network_interface {
    subnet_id = each.value.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

output "k8s_nodes_ips" {
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => instance.network_interface.0.nat_ip_address
  }
}
