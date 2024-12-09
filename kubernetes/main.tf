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
    name                        = "default"
    node_count                  = 1
    vm_size                     = "Standard_D3_v2"
    temporary_name_for_rotation = "defaultnew"
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

##############################
#######   AUDIT LOGS   #######
##############################

resource "azurerm_monitor_diagnostic_setting" "kube_audit" {
  count               = var.enable_audit_logs ? 1 : 0
  name               = "enable-audot-diagnostic-settings"
  target_resource_id = azurerm_kubernetes_cluster.aks.id

  enabled_log {
    category = "kube-audit-admin"
  }

  eventhub_name                  = azurerm_eventhub.auditlogs[0].name
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.auditlogs[0].id
}

resource "azurerm_eventhub_namespace" "auditlogs" {
  count               = var.enable_audit_logs ? 1 : 0
  name                 = "aks-audit-logs"
  location             = azurerm_resource_group.dev.location
  resource_group_name  = azurerm_resource_group.dev.name
  sku                  = "Standard"
  capacity             = 1
  auto_inflate_enabled = false
}

resource "azurerm_eventhub" "auditlogs" {
  count               = var.enable_audit_logs ? 1 : 0
  name                = "aks-audit-logs"
  namespace_name      = azurerm_eventhub_namespace.auditlogs[0].name
  resource_group_name = azurerm_resource_group.dev.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "auditlogs" {
  count               = var.enable_audit_logs ? 1 : 0
  name                = "aks-audit-logs"
  namespace_name      = azurerm_eventhub_namespace.auditlogs[0].name
  resource_group_name = azurerm_resource_group.dev.name
  listen = true
  send   = true
}

output "eventhub_connection_string" {
  value = azurerm_eventhub_namespace_authorization_rule.auditlogs[0].primary_connection_string
  sensitive = true
}

output "eventhub_name" {
  value = azurerm_eventhub.auditlogs[0].name
}


