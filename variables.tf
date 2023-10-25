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
