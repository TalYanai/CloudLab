location            = "westeurope"
resource_group_name = "cloudlab-dev-rg"
admin_username      = "taluser"
public_key_path     = "~/.ssh/id_rsa.pub"
vm_size             = "Standard_B1s"
vnet_address_space  = "10.10.0.0/16"
subnet_address_prefix = "10.10.1.0/24"
nsg_allowed_ports   = ["22", "8080"]
