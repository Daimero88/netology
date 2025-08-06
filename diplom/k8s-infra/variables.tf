variable "yc_token" {
  type        = string
  description = "Yandex.Cloud OAuth token"
  sensitive   = true
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex.Cloud cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex.Cloud folder ID"
}
