terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.93.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }
    azuread = {}
  }
}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  }
}

provider "kubectl" {
  apply_retry_count      = 10
  host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
}