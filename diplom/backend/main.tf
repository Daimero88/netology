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
}

resource "yandex_storage_bucket" "terraform_state" {
  bucket     = "ssilchin-diplom"
  access_key = var.sa_access_key
  secret_key = var.sa_secret_key

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = null
        sse_algorithm     = "AES256"
      }
    }
  }
}
