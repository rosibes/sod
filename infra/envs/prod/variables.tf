variable "aws_region" { type = string }
variable "name_prefix" { type = string }

variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }

variable "admin_cidr" { type = string }

variable "ami_id" { type = string }
variable "instance_type" { type = string }

variable "key_pair_name" { type = string }
variable "public_key_path" { type = string }

variable "common_tags" {
  type = map(string)
}