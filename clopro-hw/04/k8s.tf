resource "yandex_iam_service_account" "k8s" {
  name        = var.k8s_sa_name
  description = "Service account for Kubernetes cluster"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s_roles" {
  folder_id = var.yc_folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.k8s.id}"
  ]
}

resource "yandex_kubernetes_cluster" "k8s" {
  name        = "netology-k8s-cluster"
  description = "Netology Kubernetes Cluster"
  network_id  = yandex_vpc_network.network.id

  master {
    version = var.k8s_version
    regional {
      region = "ru-central1"
      location {
        zone      = var.private_subnets["private-a"].zone
        subnet_id = yandex_vpc_subnet.private["private-a"].id
      }
      location {
        zone      = var.private_subnets["private-b"].zone
        subnet_id = yandex_vpc_subnet.private["private-b"].id
      }
      location {
        zone      = var.private_subnets["private-d"].zone
        subnet_id = yandex_vpc_subnet.private["private-d"].id
      }
    }
    public_ip = true
    security_group_ids = [yandex_vpc_security_group.k8s_master.id]
  }

  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id

  kms_provider {
    key_id = yandex_kms_symmetric_key.k8s_secrets.id
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.k8s_roles
  ]
}

resource "yandex_kubernetes_node_group" "k8s_nodes" {
  cluster_id  = yandex_kubernetes_cluster.k8s.id
  name        = "netology-k8s-nodes"
  description = "Netology Kubernetes node group"

  instance_template {
    platform_id = "standard-v2"
    network_interface {
      nat        = true
      subnet_ids = [for subnet in yandex_vpc_subnet.public : subnet.id]
    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min     = var.k8s_node_min
      max     = var.k8s_node_max
      initial = var.k8s_node_min
    }
  }

  allocation_policy {
    location {
      zone = var.public_subnets["public-a"].zone
    }
    location {
      zone = var.public_subnets["public-b"].zone
    }
    location {
      zone = var.public_subnets["public-d"].zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
}

resource "yandex_vpc_security_group" "k8s_master" {
  name        = "k8s-master-sg"
  description = "Security group for Kubernetes master nodes"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API server"
    port          = 6443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH access"
    port          = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "kubernetes_deployment" "phpmyadmin" {
  metadata {
    name = "phpmyadmin"
    labels = {
      app = "phpmyadmin"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "phpmyadmin"
      }
    }

    template {
      metadata {
        labels = {
          app = "phpmyadmin"
        }
      }

      spec {
        container {
          name  = "phpmyadmin"
          image = "phpmyadmin/phpmyadmin"

          env {
            name  = "PMA_HOST"
            value = yandex_mdb_mysql_cluster.mysql.host[0].fqdn
          }

          env {
            name  = "PMA_PORT"
            value = "3306"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [yandex_kubernetes_cluster.k8s]
}

resource "kubernetes_service" "phpmyadmin" {
  metadata {
    name = "phpmyadmin"
  }

  spec {
    selector = {
      app = kubernetes_deployment.phpmyadmin.spec.0.template.0.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
