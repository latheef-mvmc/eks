variable "vpc_id" {
  type = string
}

variable "private_subnet_cidrs" {
  type = list(string)
}
variable "cluster_name" {
  type = string
}

variable "eks_node_security_group_id" {
  type = string
}

variable "efs_performance_mode" {
  type = string
}
variable "efs_encrypted" {
  type = bool
}

variable "efs_name" {
  type = string
}
variable "efs_throughput_mode" {
  type = string
}
variable "efs_creation_token" {
  type = string
}

