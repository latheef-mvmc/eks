#public route for public subnets
resource "aws_route_table" "eks_pub_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}
resource "aws_route" "eks_pub_route" {
  #count = length(var.public_subnet_cids)
  route_table_id = aws_route_table.eks_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"  
  gateway_id = var.igw_id
}

#private route for private subnets
resource "aws_route_table" "eks_priv_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-priv-rt"
  }
}
resource "aws_route" "eks_priv_route" {
  #count = length(var.private_subnet_cids)
  route_table_id = aws_route_table.eks_priv_rt.id
  destination_cidr_block = "0.0.0.0/0"  
  nat_gateway_id =  var.nat_gateway_id
    }

#Public subnet association
resource "aws_route_table_association" "eks_pub_rt_assoc" {
  count = length(var.public_subnet_cids)
  subnet_id      = var.public_subnet_cids[count.index]
  route_table_id = aws_route_table.eks_pub_rt.id
}

#Private subnet association
resource "aws_route_table_association" "eks_priv_rt_assoc" {
  count = length(var.private_subnet_cids)
  subnet_id      = var.private_subnet_cids[count.index]
  route_table_id = aws_route_table.eks_priv_rt.id
}
