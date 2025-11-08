output "acr_login_server" {
  value = module.acr.login_server
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
