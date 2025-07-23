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
  zone      = var.yc_zone
}

provider "kubernetes" {
  host                   = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
  cluster_ca_certificate = yandex_kubernetes_cluster.k8s.master[0].cluster_ca_certificate
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "yc"
    args = [
      "k8s",
      "create-token"
    ]
  }
}
