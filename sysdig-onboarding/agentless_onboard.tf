# module "subscription-posture" {
#   source                = "sysdiglabs/secure/azurerm//modules/services/service-principal"
#   subscription_id       = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
#   sysdig_client_id      = "771056d4-25a5-42e0-b675-a860563db81f"
# }

# module "single-subscription-threat-detection" {
#   source               = "sysdiglabs/secure/azurerm//modules/services/event-hub-data-source"
#   subscription_id      = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
#   region               = "brazilsouth"
#   sysdig_client_id     = "771056d4-25a5-42e0-b675-a860563db81f"
#   event_hub_namespace_name = "sysdig-secure-events-wxps"
#   resource_group_name = "sysdig-secure-events-wxps"
#   diagnostic_settings_name = "sysdig-secure-events-wxps"
# }

# resource "sysdig_secure_cloud_auth_account" "azure_subscription_c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a" {
#   enabled       = true
#   provider_id   = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
#   provider_type = "PROVIDER_AZURE"

#   feature {

#     secure_threat_detection {
#       enabled    = true
#       components = ["COMPONENT_EVENT_BRIDGE/secure-runtime"]
#     }

#     secure_config_posture {
#       enabled    = true
#       components = ["COMPONENT_SERVICE_PRINCIPAL/secure-posture"]
#     }
#   }
#   component {
#     type     = "COMPONENT_SERVICE_PRINCIPAL"
#     instance = "secure-posture"
#     service_principal_metadata = jsonencode({
#       azure = {
#         active_directory_service_principal= {
#           account_enabled           = true
#           display_name              = module.subscription-posture.service_principal_display_name
#           id                        = module.subscription-posture.service_principal_id
#           app_display_name          = module.subscription-posture.service_principal_app_display_name
#           app_id                    = module.subscription-posture.service_principal_client_id
#           app_owner_organization_id = module.subscription-posture.service_principal_app_owner_organization_id
#         }
#       }
#     })
#   }
#   component {
#     type     = "COMPONENT_EVENT_BRIDGE"
#     instance = "secure-runtime"
#     event_bridge_metadata = jsonencode({
#       azure = {
#         event_hub_metadata= {
#           event_hub_name      = module.single-subscription-threat-detection.event_hub_name
#           event_hub_namespace = module.single-subscription-threat-detection.event_hub_namespace
#           consumer_group      = module.single-subscription-threat-detection.consumer_group_name
#         }
#       }
#     })
#   }
#   provider_alias     = module.subscription-posture.subscription_alias
#   provider_tenant_id = "d2150b2f-9c8e-4d2f-8639-82fbcdffd1e8"
#   depends_on         = [module.single-subscription-threat-detection, module.subscription-posture]
# }

