output "public_subnet_cids" {
  value = aws_subnet.eks_pub_subnet[*].id
       
}
output "private_subnet_cids" {
  value = aws_subnet.eks_pri_subnet[*].id
}