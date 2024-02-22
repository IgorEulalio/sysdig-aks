resource "helm_release" "sysdig_agent" {

  name             = "sysdig-agent"
  namespace        = "sysdig-agent"
  repository       = "https://charts.sysdig.com"
  chart            = "sysdig-deploy"
  create_namespace = true

  values = [
    templatefile("${path.module}/values/sysdig-values.yaml", {
      cluster_name = local.name
      access_key   = var.sysdig_accesskey
    }),
  ]

  depends_on = [azurerm_kubernetes_cluster.aks]
}

resource "helm_release" "registry_scanner" {
  name             = "registry-scanner"
  chart            = "registry-scanner"
  repository       = "https://charts.sysdig.com"
  create_namespace = true
  namespace        = "sysdig-scanner" # Adjust as needed

  values = [
    templatefile("values/sysdig-scanner-values.yaml", {
      secure_base_url   = var.sysdig_secure_url
      secure_api_token  = var.sysdig_secure_api_token
      registry_url      = azurerm_container_registry.acr.login_server
      registry_user     = var.service_account_user
      registry_password = var.service_account_password
    })
  ]
}

## agentless onboarding
module "single-subscription" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription"
  name   = "igoreul"
}
