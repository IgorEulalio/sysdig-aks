# resource "helm_release" "crossplane" {
#     name      = "crossplane"
#     namespace = "crossplane-system"
#     repository       = "https://charts.crossplane.io/stable"
#     chart            = "crossplane"
#     version          = "1.16.0"
#     create_namespace = true
    
#     values = [
#         templatefile("${path.module}/values/crossplane.yaml", {
#         cluster_name     = local.name
#         }),
#     ]
    
#     depends_on = [azurerm_kubernetes_cluster.aks]
  
# }