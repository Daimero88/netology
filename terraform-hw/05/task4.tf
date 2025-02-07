variable "single_ip" {
  type        = string
  description = "IP address"
  default     = "1920.1680.0.1"
  validation {
    condition     = can(regex("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.single_ip))
    error_message = "Error! It's not IP"
  }
}

variable "ip_list" {
  type        = list(string)
  description = "IP list"
  default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  validation {
    condition = alltrue([
    for ip in var.ip_list : can(regex("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))
    ])
    error_message = "Error! One or more IP in list are sucks"
  }
}
