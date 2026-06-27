
variable "cluster_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "public_subnet_cids" {
  type = list(string)   
}
variable "private_subnet_cids" {
  type = list(string)   
}
variable "region" {
  type = string
}
variable "aws_profile" {
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
variable "node_security_group_id" {
  description = "Security group ID for EKS worker nodes"
  type        = string
}


variable "key_name" {
  type = string
}

