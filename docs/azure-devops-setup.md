# Azure DevOps Setup Notes for devops-lab

1. Service connections:
   - Create `Azure Resource Manager` service connection (`azure-spn`) with subscription-level Contributor or restricted RBAC.
2. Variable groups:
   - Create `infra-secrets` with terraform backend details (storage account, container, key, resource group).
   - Create `pipeline-vars` with `acrName`, `resourceGroup`, `aksClusterName`.
3. Environments & approvals:
   - Add environment `terraform-apply` and require manual approval for `TerraformApply` stage.
   - Add environment `aks-demo` for production-like deployment approvals.
4. Permissions:
   - Ensure the SPN used by `azure-spn` has `AcrPush` and `Contributor` roles where needed.
