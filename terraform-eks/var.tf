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
variable "key_name" {
  type = string
}

variable "efs_creation_token" {
  description = "Creation token for the Amazon EFS file system."
  type        = string
}
variable "efs_name" {
  description = "Name of the Amazon EFS file system."
  type        = string
}

variable "efs_performance_mode" {
  description = "Performance mode of the Amazon EFS file system."
  type        = string
}

variable "efs_throughput_mode" {
  description = "Throughput mode of the Amazon EFS file system."
  type        = string
}

# variable "security_group_name" {
#   description = "Name of the security group."
#   type        = string
# }

variable "efs_encrypted" {
  description = "Whether the Amazon EFS file system is encrypted."
  type        = bool
}