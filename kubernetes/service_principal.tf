data "azuread_client_config" "current" {}

resource "azuread_application" "registry_scanner" {
  provider     = azuread
  display_name = "sysdig-registry-scanner"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "registry_scanner_sp" {
  client_id                    = azuread_application.registry_scanner.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "azuread_service_principal_password" "registry_scanner_sp_password" {
  service_principal_id = azuread_service_principal.registry_scanner_sp.id
}

resource "azurerm_role_assignment" "registry_scanner_acrpull" {
  #   scope                = "/subscriptions/${local.subscription_id}/resourceGroups/${azurerm_resource_group.dev.name}/providers/Microsoft.ContainerRegistry/registries/${azurerm_container_registry.acr.name}"
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azuread_service_principal.registry_scanner_sp.id
}

output "registry_scanner_sp_password" {
  value     = azuread_service_principal_password.registry_scanner_sp_password.value
  sensitive = true
}