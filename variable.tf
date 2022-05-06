variable "location"{
    type = string
    description = "Project location"
    default = "eastus"
}

variable "postfix"{
    type = string
    description = "Project postfix name"
    default = "dev"
}

variable "prefix"{
    type = string
    description = "Project prefix name"
}

variable "pooltype"{
    type = string
    description = "wvd pool type"
}

variable "loadbalancer"{
    type = string
    description = "wvd pool LB"
}

variable "appgroup"{
    type = string
    description = "wvd pool app group"
}

variable "start_vm_on_connect" {
  type        = bool
  description = "Enables or disables the Start VM on Connection Feature"
}

variable "custom_rdp_properties" {
  type        = string
  description = "A valid custom RDP properties string for the Virtual Desktop Host Pool"
}