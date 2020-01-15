# ============================================================ REQUIRED

variable "install_id" {
  type        = string
  description = "A prefix to use for resource names"
}

variable "location" {
  type        = string
  description = "The Azure Location to build into"
}

variable "rg_name" {
  type        = string
  description = "The Azure Resource Group to build into"
}

variable "dns" {
  type = object({
    domain  = string
    rg_name = string
    ttl     = number
  })
  description = "Expects keys: [domain, rg_name, ttl]"
}

variable "lb_port" {
  type        = map(list(string))
  description = "Expects map with format `name: [frontend_port, protocol, backend_port]` for all routes."
}

variable "resource_prefix" {
  type        = string
  description = "Prefix name for resources"
}

# ============================================================ OPTIONAL
variable "internal_lb" {
  type        = bool
  description = "Create internal lb"
  default     = false
}

# TFE is using k8s under the hood. K8s requires an LB in front of its master nodes.
# Due to Azure internal LB limitation (it does not SNAT) LB has to be public or
# master-lb-master traffic has to be SNATed somehow. In Azure this can only be
# done through public IP use.
#
variable "public_ip" {
  type        = string
  description = "A public ip address that this installation should accessible from."
  default     = ""
}

# Sometimes it is required to pre allocate private IP for private lb
variable "private_ip" {
  type        = string
  description = "Private IP address for static IP allocation on LB"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet to put internal load balancer into"
  default     = ""
}

variable "lb_probe_interval" {
  type        = number
  description = "The interval for the Loadbalancer healthcheck probe."
  default     = 10
}

variable "lb_probe_unhealthy_threshold" {
  type        = number
  description = "The amount of unhealthy checks before marking a node unhealthy."
  default     = 2
}

variable "snat_lb" {
  type = object({
    id                             = string
    frontend_ip_configuration_name = string
  })

  description = "Use this loadbalancer for outgoing SNAT"
  default     = null
}

# ============================================================ MISC

# LB resource names

locals {
  prefix   = "${var.resource_prefix}-${var.install_id}"
  frontend = "${local.prefix}-fe"
}

