resource "aws_eip" "eks_nat_eip" {
#count = length(var.public_subnet_cidrs)
domain = "vpc"

  tags = {
    Name = "${var.name}-nat-eip"
  }
}
  

resource "aws_nat_gateway" "eks_nat_gw" {
  #count = length(var.public_subnet_cidrs)   
  allocation_id = aws_eip.eks_nat_eip.id   
  subnet_id     = var.public_subnet_cidrs[0]

  tags = {
    Name = "${var.name}-nat-gw"
  }
  depends_on = [aws_eip.eks_nat_eip]
}
