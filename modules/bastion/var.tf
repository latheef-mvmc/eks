variable "ami_id" {
  type = string
}
variable "key_name" {
  type = string
}
# variable "bastion_instance_type" {
#   type = string
# }

variable "bastion_name" {
  type = string
}



variable "vpc_id" {
    type = string
}

variable "public_subnet_id" {
    type = string
}

# variable "allowed_ssh_cidr" {
#     type = string
# }