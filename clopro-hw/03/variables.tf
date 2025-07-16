variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "ssilchin-110725"
}

variable "image_path" {
  description = "Path to local image file"
  type        = string
  default     = "image.jpg"
}

variable "kms_key_name" {
  description = "Name of the KMS key"
  type        = string
  default     = "s3-encryption-key"
}
