module "onboarding" {
  source          = "sysdiglabs/secure/azurerm//modules/onboarding"
  subscription_id = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
  tenant_id       = "d2150b2f-9c8e-4d2f-8639-82fbcdffd1e8"
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