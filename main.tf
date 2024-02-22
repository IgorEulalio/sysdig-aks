resource "azurerm_resource_group" "dev" {
  name     = "igoreul-dev-resource-group"
  location = "brazilsouth"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  dns_prefix          = local.dns_name

  node_os_channel_upgrade = "NodeImage"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "containerregistryigoreul"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  sku                 = "Standard"
  admin_enabled       = false // It's recommended to use a service principal or managed identity for authentication
}
