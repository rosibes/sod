variable "aws_region" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "pub_subnet_cidr" {
    type = string
}

variable "admin_cidr" {
  description = "CIDR allowed to SSH into the EC2 instance"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr))
    error_message = "admin_cidr must be a valid CIDR, e.g. 86.120.45.23/32"
  }
}