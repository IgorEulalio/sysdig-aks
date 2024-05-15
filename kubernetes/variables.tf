variable "sysdig_accesskey" {
  description = "sysdig access key"
  sensitive   = true
  type        = string
}

variable "sysdig_secure_url" {
  description = "endpoint for sysdig secure"
  type        = string
  default     = "https://app.us4.sysdig.com"
}

variable "sysdig_secure_api_token" {
  description = "sysdig secure api token"
  type        = string
  sensitive   = true
}

variable "gar_secret" {
  description = "gar secret"
  type        = string
  sensitive   = true
}

# variable "service_account_user" {
#   description = "service account user"
#   type        = string
# }

# variable "service_account_password" {
#   description = "service account password"
#   type        = string
#   sensitive   = true
# }