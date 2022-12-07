variable "vpc_id" {
  description = "VPC ID to gateway"
  type        = string
  default     = null
}

variable "name" {
  description = "Name to gateway used in tags, if not defined will be used tf-internet-gateway to igtw or tf-nat-gateway to ngtw"
  type        = string
  default     = null
}

variable "gateway_type" {
  description = "Gateway type, can be internet, nat or both"
  type        = string
  default     = "internet"
}

variable "connectivity_type" {
  description = "Connectivity type to nat gateway, can be public or private, if connectivity type setup as public will be created static ip to Nat gateway"
  type        = string
  default     = "public"
}

variable "private_ip_id" {
  description = "Private IP ID to allocation in nat gateway, if null a private IPv4 address will be automatically assigned"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID to nat gateway"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to gateways"
  type        = map(any)
  default     = {}
}

variable "tags_eip" {
  description = "Tags to gateway Elastic IP"
  type        = map(any)
  default     = {}
}
