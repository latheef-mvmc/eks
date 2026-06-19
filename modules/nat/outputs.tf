output "nat_gateway_id" {
  value = aws_nat_gateway.eks_nat_gw.id
}

output "nat_gateway_eip" {
  value = aws_eip.eks_nat_eip.public_ip
}