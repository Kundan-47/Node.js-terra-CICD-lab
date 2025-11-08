variable "resource_group_name" {}
variable "name" {}
variable "location" {}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = true
  enable_rbac_authorization   = true
}

output "id" { value = azurerm_key_vault.this.id }
