###
# Author: Justin Quijano
###

# Variables for vpc module
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "cidr_block" {
  description = "Address space for VPC"
  type        = string
}

variable "public_subnet" {
  description = "IPv4 block for public subnet"
  type        = string
}

variable "private_subnet" {
  description = "IPv4 block for private subnet"
  type        = string
}

variable "default_route" {
  description = "Default route for route table"
  default     = "0.0.0.0/0"
}
