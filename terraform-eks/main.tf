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
  source              = "../modules/route"
  vpc_id              = module.vpc.vpc_id
  vpc_name            = var.vpc_name
  igw_id              = module.igw.igw_id
  public_subnet_cids  = module.subnets.public_subnet_cids
  private_subnet_cids = module.subnets.private_subnet_cids
  nat_gateway_id      = module.nat.nat_gateway_id
}
module "eks" {
  source       = "../modules/eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  # ami_id = var.ami_id
  public_subnet_cids  = module.subnets.public_subnet_cids
  private_subnet_cids = module.subnets.private_subnet_cids
  #modules.security_group_id = module.security.eks_cluster_sg_id
  #node_security_group_id = module.security.eks_node_sg_id
  node_security_group_id = module.security.node_security_group_id
  region                 = var.region
  aws_profile            = var.aws_profile
  node_group_name        = var.node_group_name
  instance_type          = var.instance_type
  desired_size           = var.desired_size
  max_size               = var.max_size
  min_size               = var.min_size

}

module "security" {
  source       = "../modules/security"
  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
}


