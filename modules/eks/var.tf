
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
