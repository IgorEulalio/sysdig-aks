terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.87.0"
    }
    sysdig = {
      source = "sysdiglabs/sysdig"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = "c6580cd6-8f4b-4b41-8fdc-7b1d0ac76f6a"
  features {}
}

provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = var.sysdig_accesskey
}