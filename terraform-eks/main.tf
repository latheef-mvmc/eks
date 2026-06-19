module "vpc" {
  source   = "../modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source               = "../modules/subnets"
  vpc_id               = module.vpc.vpc_id
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "igw" {
  source   = "../modules/igw"
  vpc_id   = module.vpc.vpc_id
  vpc_name = var.vpc_name
}

module "nat" {
  source = "../modules/nat"
  #eip_allocation_id = module.igw.igw_id
  #public_subnet_id = module.subnets.public_subnet_cids[0] 
  #vpc_id = module.vpc.vpc_id
  public_subnet_cidrs = module.subnets.public_subnet_cids
  name                = var.vpc_name
}

module "route" {
  source   = "../modules/route"
  vpc_id   = module.vpc.vpc_id
  vpc_name = var.vpc_name
  igw_id   = module.igw.igw_id
  public_subnet_cids  = module.subnets.public_subnet_cids
  private_subnet_cids = module.subnets.private_subnet_cids
  nat_gateway_id     = module.nat.nat_gateway_id
}
  module "eks" {
    source = "../modules/eks"
    cluster_name = var.cluster_name
    vpc_id = module.vpc.vpc_id
    public_subnet_cids  = module.subnets.public_subnet_cids
    private_subnet_cids = module.subnets.private_subnet_cids
    region = var.region
    aws_profile = var.aws_profile  
    #cluster_version     = var.cluster_version
    #node_group_name     = var.node_group_name
    #node_group_size     = var.node_group_size
  }

