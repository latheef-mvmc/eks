#public route table outputs
output "route_table_id" {
  value = aws_route_table.eks_pub_rt.id
}
output "route_table_name" {
  value = aws_route_table.eks_pub_rt.tags["Name"]
}
output "route_table_routes" {
  value = aws_route_table.eks_pub_rt.route
}
#private route table outputs
output "route_table_id_priv" {
  value = aws_route_table.eks_priv_rt.id
}
output "route_table_name_priv" {
  value = aws_route_table.eks_priv_rt.tags["Name"]
}
output "route_table_routes_priv" {
  value = aws_route_table.eks_priv_rt.route
}

