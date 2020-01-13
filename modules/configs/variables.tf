# === Required

variable "primary_count" {
  type        = number
  description = "The count of primary instances being created."
}

variable "license_b64" {
  type        = string
  description = "Replicated base64 encoded license for the application"
}

variable "cluster_endpoint" {
  type        = string
  description = "URI to the cluster"
}

variable "cluster_api_endpoint" {
  type        = string
  description = "URI to the cluster api"
}

variable "distribution" {
  type        = string
  description = "Type of linux distribution to use. (ubuntu or rhel)"
}

variable "encryption_password" {
  type        = string
  description = "The password for data encryption in non-external services modes."
}

variable "cert_thumbprint" {
  type        = string
  description = "The thumbprint for the Azure Key Vault Certificate object generated from the provided PFX certificate."
}

variable "assistant_port" {
  description = "Port the assitant sidecar-like node service is running on."
}

variable "http_proxy_url" {
  type        = string
  description = "HTTP(S) Proxy URL"
}

variable "installer_url" {
  type        = string
  description = "URL to the cluster installer tool"
}

variable "iact" {
  type = object({
    subnet_list       = list(string)
    subnet_time_limit = string
  })
  description = "Expects keys: [subnet_list, subnet_time_limit]"
}

variable "postgresql" {
  type = object({
    user         = string
    password     = string
    address      = string
    database     = string
    extra_params = string
  })
  description = "Expects keys: [user, password, address, database, extra_params]"
}

variable "azure_es" {
  type = object({
    account_name = string
    account_key  = string
    container    = string
  })
  description = "Expects keys: [account_name, account_key, container]"
}

variable "airgap" {
  type = object({
    enable        = bool
    package_url   = string
    installer_url = string
  })
  description = "Expects keys: [enable, package_url, installer_url]"
}

variable "weave_cidr" {
  type        = string
  description = "custom weave CIDR range"
}

variable "repl_cidr" {
  type        = string
  description = "custom replicated service CIDR range"
}

variable "release_sequence" {
  type        = string
  description = "The sequence ID for the Terraform Enterprise version to pin the cluster to."
}

# === Optional

variable "ca_bundle_url" {
  type        = string
  description = "URL to CA certificate file used for the internal `ptfe-proxy` used for outgoing connections"
}

# === Misc

locals {
  installation_type = var.postgresql.database != "" && var.azure_es.account_name != "" ? "production" : "poc"
}

resource "random_pet" "console_password" {
  length = 3
}

resource "random_string" "bootstrap_token_id" {
  length  = 6
  upper   = false
  special = false
}

resource "random_pet" "default_enc_password" {
  length = 4
}

resource "random_string" "setup_token" {
  length  = 32
  upper   = false
  special = false
}

resource "random_string" "bootstrap_token_suffix" {
  length  = 16
  upper   = false
  special = false
}

