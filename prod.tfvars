location            = "northeurope"
resource_group_name = "cloudlab-prod-rg"
admin_username      = "cloudadmin"
public_key_path     = "~/.ssh/id_rsa.pub"
vm_size             = "Standard_B2ms"
vnet_address_space  = "10.20.0.0/16"
subnet_address_prefix = "10.20.1.0/24"
nsg_allowed_ports   = ["22", "80", "443"]
