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

variable "region" {
  description = "region"
  type        = string
  default     = "us4"
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

variable "enable_prometheus" {
  description = "value to enable prometheus"
  type        = bool
  default     = false
}

variable "enable_falco" {
  description = "value to enable falco"
  type        = bool
  default     = false
}

variable "enable_audit_logs" {
  description = "value to enable audit logs"
  type        = bool
  default     = true
}