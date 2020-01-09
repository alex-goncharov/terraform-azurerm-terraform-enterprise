# ============================================================ REQUIRED

variable "install_id" {
  type        = string
  description = "A prefix to use for resource names"
}

variable "rg_name" {
  type        = string
  description = "The Azure Resource Group to build into"
}

variable "vnet" {
  type        = map(string)
  description = "The Azure Virtual Network to build into. Expects keys [name, rg_name]"
}

variable "subnet_name" {
  type        = string
  description = "The Azure Virtual Network Subnet to build into"
}

variable "domain_rg_name" {
  type        = string
  description = "Resource group of the DNS zone"
  default     = ""
}

variable "key_vault" {
  type = object({
    name    = string
    rg_name = string
  })
  description = "Expects keys: [name, rg_name] (key_vault name and Azure resource group that key vault resides in.)"
}

variable "tls" {
  type = object({
    pfx_cert    = string
    pfx_cert_pw = string
  })
  description = "Expects keys: [pfx_cert, pfx_cert_pw] (the path to a pfx certificate for the dns zone, the password for that certificate)"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix name for resources"
}

variable "key_type" {
  type        = string
  description = "Type of key-pair used to generate the provided certificate"
}

variable "key_size" {
  type        = string
  description = "Byte size for the key-pair used to generate the provided certificate"
}

# ============================================================ MISC

locals {
  # path.root for remote modules to work properly.

  key_name                = "${var.resource_prefix}-${var.install_id}"
  prefix                  = "${var.resource_prefix}-${var.install_id}"
  rendered_vnet_rg_name   = coalesce(var.vnet["rg_name"], var.rg_name)
  rendered_kv_rg_name     = coalesce(var.key_vault["rg_name"], var.rg_name)
  rendered_domain_rg_name = coalesce(var.domain_rg_name, var.rg_name)
}

