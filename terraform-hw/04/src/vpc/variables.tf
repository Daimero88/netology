variable "vpc_name" {
  type    = string
  description = "VPC network&subnet name"
}

variable "zone" {
  type    = string
  description = "zone for vpc"
}

variable "cidr" {
  type    = string
  description = "cidr for vpc"
}
