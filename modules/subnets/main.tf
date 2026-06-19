#Public subnets for EKS cluster
resource "aws_subnet" "eks_pub_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-pub_subnet-${count.index + 1}"
    
  }
}
#Private subnets for EKS cluster
resource "aws_subnet" "eks_pri_subnet" {    
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-pri_subnet-${count.index + 1}"
    
  }
}

