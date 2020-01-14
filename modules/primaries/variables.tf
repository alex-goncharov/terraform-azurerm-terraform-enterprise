# ============================================================ REQUIRED

variable "install_id" {
  type        = string
  description = "A prefix to use for resource names"
}

variable "rg_name" {
  type        = string
  description = "The Azure Resource Group to build into"
}

variable "location" {
  type        = string
  description = "The Azure Location to build into"
}

variable "subnet_id" {
  type        = string
  description = "The Azure Subnet to build into"
}

variable "os_disk_size" {
  type        = string
  description = "Specifies the size of the OS Disk in gigabytes."
}

variable "username" {
  type        = string
  description = "Specifies the name of the local administrator account."
}

variable "cluster_backend_pool_id" {
  type        = list(string)
  description = "The id of the backend pool for the cluster loadbalancer."
}

variable "cloud_init_data" {
  type        = list(string)
  description = "Rendered cloud-init templates to pass to the vms."
}

variable "storage_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Expects keys: [publisher, offer, sku, version]"
}

variable "vm" {
  type = object({
    count = number
    size  = string
  })
  description = "Expects keys: [count, size]"
}

variable "ssh_key" {
  type        = string
  description = "SSH public to provision nodes with"
}

variable "key_vault" {
  type = object({
    id       = string
    cert_uri = string
  })
  description = "Expects keys: [id, cert_uri]"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix name for resources"
}

# ============================================================ MISC

locals {
  prefix = "${var.resource_prefix}-${var.install_id}-primary"

  ip_conf_name = "${local.prefix}-ip-conf"
}

