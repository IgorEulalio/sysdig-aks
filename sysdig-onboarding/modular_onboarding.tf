module "onboarding" {
  source          = "sysdiglabs/secure/azurerm//modules/onboarding"
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
}

module "event-hub" {
  source                   = "sysdiglabs/secure/azurerm//modules/integrations/event-hub"
  subscription_id          = module.onboarding.subscription_id
  region                   = local.region
  sysdig_secure_account_id = module.onboarding.sysdig_secure_account_id
  enable_entra             = false
  resource_group           = local.resource_group
}

resource "sysdig_secure_cloud_auth_account_feature" "threat_detection" {
  account_id = module.onboarding.sysdig_secure_account_id
  type       = "FEATURE_SECURE_THREAT_DETECTION"
  enabled    = true
  components = [module.event-hub.event_hub_component_id]
  depends_on = [module.event-hub]
}

module "config-posture" {
  source                   = "sysdiglabs/secure/azurerm//modules/config-posture"
  subscription_id          = module.onboarding.subscription_id
  sysdig_secure_account_id = module.onboarding.sysdig_secure_account_id
}

resource "sysdig_secure_cloud_auth_account_feature" "config_posture" {
  account_id = module.onboarding.sysdig_secure_account_id
  type       = "FEATURE_SECURE_CONFIG_POSTURE"
  enabled    = true
  components = [module.config-posture.service_principal_component_id]
  depends_on = [module.config-posture]
}