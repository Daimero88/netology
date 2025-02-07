variable "uppercase_symbol" {
  type = string
  description = "любая строка"
  default = "Sergei"
  validation {
    condition = can(regex("^[^A-Z]*$", var.uppercase_symbol))
    error_message = "Error! The variable contains an UPPERCASE symbol"
  }
}

variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
    }
}
