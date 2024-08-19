resource "helm_release" "prometheus" {
    name      = "prometheus"
    namespace = "monitoring"
    repository       = "https://prometheus-community.github.io/helm-charts"
    chart            = "kube-prometheus-stack"
    version          = "61.6.0"
    create_namespace = true
    
    values = [
        file("${path.module}/values/prometheus.yaml"),
    ]
    
    depends_on = [azurerm_kubernetes_cluster.aks]
  
}