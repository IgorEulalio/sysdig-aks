resource "helm_release" "sysdig_agent" {

  name             = "sysdig-agent"
  namespace        = "sysdig-agent"
  repository       = "https://charts.sysdig.com"
  chart            = "sysdig-deploy"
  version          = "1.61.1"
  create_namespace = true

  values = [
    templatefile("${path.module}/values/sysdig-values.yaml", {
      cluster_name     = local.name
      access_key       = var.sysdig_accesskey,
      secure_api_token = var.sysdig_secure_api_token,
      region           = var.region,
    }),
  ]

  depends_on = [azurerm_kubernetes_cluster.aks]
}

# resource "helm_release" "sysdig_cluster_shield" {

#   name      = "sysdig-cluster-shield"
#   namespace = "sysdig-cluster-shield"
#   # repository       = "oci://quay.io/sysdig"
#   repository       = "oci://us-docker.pkg.dev/sysdig-artifact-registry-dev/gar-charts"
#   chart            = "cluster-shield"
#   version          = "0.0.0-5632308"
#   create_namespace = true

#   values = [
#     templatefile("${path.module}/values/cluster-shield-values.yaml", {
#       cluster_name     = local.name
#       access_key       = var.sysdig_accesskey,
#       secure_api_token = var.sysdig_secure_api_token,
#       url              = var.sysdig_secure_url,
#       # gar_secret_name  = kubernetes_secret_v1.gar_cred.metadata.0.name,
#       gar_secret_name  = "gar-cred",
#     }),
#   ]

#   atomic = true

#   depends_on = [azurerm_kubernetes_cluster.aks]
# }

# resource "kubernetes_secret_v1" "gar_cred" {
#   metadata {
#     name      = "gar-cred"
#     namespace = "sysdig-cluster-shield"
#   }

#   type = "kubernetes.io/dockerconfigjson"

#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         "us-docker.pkg.dev" = {
#           "username" = "oauth2accesstoken"
#           "password" = var.gar_secret
#           "email"    = "igor.eulalio@sysdig.com"
#           # "auth"     = base64encode("${igor.eulalio@sysdig.com}:${var.gar_secret}")
#         }
#       }
#     })
#   }
# }
# resource "helm_release" "registry_scanner" {
#   name             = "registry-scanner"
#   chart            = "registry-scanner"
#   repository       = "https://charts.sysdig.com"
#   create_namespace = true
#   namespace        = "sysdig-scanner" # Adjust as needed

#   values = [
#     templatefile("values/sysdig-registry-scanner-values.yaml", {
#       secure_base_url  = var.sysdig_secure_url
#       secure_api_token = var.sysdig_secure_api_token
#       registry_url     = azurerm_container_registry.acr.login_server
#       # registry_user     = var.service_account_user
#       registry_user = azuread_service_principal.registry_scanner_sp.application_id
#       # registry_password = var.service_account_password
#       registry_password = azuread_service_principal_password.registry_scanner_sp_password.value
#     })
#   ]
# }
