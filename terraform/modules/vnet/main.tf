variable "resource_group" {}
variable "vnet_name" {}
variable "location" {}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
}

output "id" { value = azurerm_virtual_network.this.id }
