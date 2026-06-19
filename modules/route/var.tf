variable "igw_id" {
  type        = string
}
variable "public_subnet_cids" {
  type        = list(string)   
}
variable "vpc_name" {
  type        = string
}
# variable "route_table_id" {
#   type        = string
# }
variable "vpc_id" {
  type        = string
}
variable "private_subnet_cids" {
  type        = list(string)   
}   
variable "nat_gateway_id" {
  type        = string
}
