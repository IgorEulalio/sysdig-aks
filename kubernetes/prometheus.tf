# resource "helm_release" "prometheus" {
#     name      = "prometheus"
#     namespace = "monitoring"
#     repository       = "https://prometheus-community.github.io/helm-charts"
#     chart            = "kube-prometheus-stack"
#     version          = "9.4.1"
#     create_namespace = true
    
#     values = [
#         templatefile("${path.module}/values/prometheus.yaml", {
#         cluster_name     = local.name
#         }),
#     ]
    
#     depends_on = [azurerm_kubernetes_cluster.aks]
  
# }