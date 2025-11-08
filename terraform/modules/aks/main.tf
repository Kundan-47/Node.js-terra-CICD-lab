# Define variables inline (no variables.tf needed)
variable "resource_group_name" {}
variable "cluster_name" {}
variable "location" {}
variable "node_count" {}
variable "acr_name" {}

provider "azurerm" {
  features {}
}

# Create the AKS Cluster
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Get ACR info (for linking permissions)
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_kubernetes_cluster.this]
}

# Give AKS permission to pull from ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
}

# Output kubeconfig (still okay inline)
output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}
