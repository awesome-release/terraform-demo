locals {
  api_hostname = "${var.namespace}-api.${var.tld_name}"
}

variable "credentials_profile" {
  type = string
  description = "The credentials to use for this environment"
  default = "default"
}

variable "namespace" {
  type        = string
  description = "The namespace for this module."
  default     = "default"
}

variable "stage_name" {
  type        = string
  description = "The name of the stage, prod, staging, or v1, v2, etc."
  default     = "v1"
}

variable "tld_name" {
  type        = string
  description = "The dns name for the tld"
  default     = "example.com"
}
