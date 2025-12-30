variable "name_prefix" {
  type        = string
  description = "Prefix used for naming resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to place the instance in"
}

variable "admin_cidr" {
  type        = string
  description = "CIDR allowed to SSH into instance (your public IP /32)"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_pair_name" {
  type        = string
  description = "AWS key pair name"
}

variable "public_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "common_tags" {
  type = map(string)
}