variable "yandex_token" {
  type        = string
  description = "Yandex.Cloud OAuth or IAM token"
  sensitive   = true
}

variable "yandex_cloud_id" {
  type        = string
  description = "Yandex.Cloud Cloud ID"
}

variable "yandex_folder_id" {
  type        = string
  description = "Yandex.Cloud Folder ID"
}

variable "sa_access_key" {
  type        = string
  description = "Service account access key"
  sensitive   = true
}

variable "sa_secret_key" {
  type        = string
  description = "Service account secret key"
  sensitive   = true
}
