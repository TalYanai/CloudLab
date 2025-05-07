variable "location" {
  default = "westeurope"
}

variable "resource_group_name" {
  default = "cloudlab-rg"
}

variable "admin_username" {
  default = "taluser"
}

variable "public_key_path" {
  default = "C:/Users/Tal/.ssh/id_rsa.pub"
}
variable "vm_size" {
  type        = string
  description = "The size of the virtual machine"
  default     = "Standard_B1s"
}

variable "vnet_address_space" {
  type        = string
  description = "The CIDR block for the virtual network"
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  type        = string
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "nsg_allowed_ports" {
  type        = list(string)
  description = "List of ports to allow inbound in the NSG"
  default     = ["22", "8080"]
}
