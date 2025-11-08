provider "azurerm" {
  features {}
}

# Generate random suffix for uniqueness
resource "random_id" "suffix" {
  byte_length = 2
}

# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "devops-lab-rg"
  location = "East US"
}

# Virtual Network
module "vnet" {
  source         = "./modules/vnet"
  resource_group = "devops-lab-rg"
  vnet_name      = "devopslabvnet"
  location       = "East US"
}

# Azure Container Registry
module "acr" {
  source              = "./modules/acr"
  resource_group_name = "devops-lab-rg"
  acr_name            = "devopslabacr"
  location            = "East US"
}

# Data source to get ACR info (forces dependency)
data "azurerm_container_registry" "acr" {
  name                = "devopslabacr"
  resource_group_name = "devops-lab-rg"
  depends_on          = [module.acr] # ✅ ensures ACR is created first
}

# AKS Cluster
module "aks" {
  source              = "./modules/aks"
  resource_group_name = "devops-lab-rg"
  cluster_name        = "devops-lab-aks"
  location            = "East US"
  node_count          = 2
  acr_name            = data.azurerm_container_registry.acr.name
}


# Key Vault
module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = "devops-lab-rg"
  name                = "devopslabkv"
  location            = "East US"
}
