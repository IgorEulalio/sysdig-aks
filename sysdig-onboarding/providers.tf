terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.87.0"
    }
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = "~> 1.19.0"
    }
  }
}

provider "azurerm" {
  features { }
  subscription_id = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
  tenant_id       = "d2150b2f-9c8e-4d2f-8639-82fbcdffd1e8"
}

provider "azuread" {
  tenant_id       = "d2150b2f-9c8e-4d2f-8639-82fbcdffd1e8"
}

provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = var.sysdig_accesskey
}