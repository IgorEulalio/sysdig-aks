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

  depends_on = [ azurerm_kubernetes_cluster.aks ]
}

## agentless onboarding
module "single-subscription" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription"
  name   = "igoreul"
}
