terraform {
  backend "azurerm" {
    resource_group_name   = "devops-lab-tfstate-rg"              # your actual RG name
    storage_account_name  = "tfstatebackendstorageaks" # the storage account you just created
    container_name        = "tfstate"
    key                   = "infra.tfstate"
    use_azuread_auth      = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
