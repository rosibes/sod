variable "aws_region" {
    type = string
    default = "eu-west-1"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "pub_subnet_cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "admin_cidr" {
     type = string
     default = "128.77.15.17/32"
}