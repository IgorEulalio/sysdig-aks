resource "helm_release" "falco" {
  count            = var.enable_falco ? 1 : 0
  name             = "falco"
  namespace        = "falco"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
  version          = "4.15.1"
  create_namespace = true

  values = [
    file("${path.module}/values/falco.yaml"),
  ]

  depends_on = [azurerm_kubernetes_cluster.aks]
}