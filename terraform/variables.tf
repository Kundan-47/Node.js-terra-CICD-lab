variable "location" { default = "East US 2" }
variable "project" { default = "devops-lab" }

# Backend state
variable "tfstate_resource_group" { default = "devops-lab-tfstate-rg" }
variable "tfstate_storage_account" { default = "devops-labtfstate" }
variable "tfstate_container" { default = "tfstate" }
variable "tfstate_key" { default = "terraform.tfstate" }

variable "acr_name" { default = "devopslabacr" }
variable "acr_id" {
  type        = string
  description = "ACR resource ID for granting pull permissions to AKS"
}

variable "aks_cluster_name" { default = "aks-demo" }
variable "aks_node_count" { default = 2 }
