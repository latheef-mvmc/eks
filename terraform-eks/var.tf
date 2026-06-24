variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "region" {
  type = string
}
variable "aws_profile" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}
variable "node_group_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
# variable "ami_id" {
#   type = string
# }