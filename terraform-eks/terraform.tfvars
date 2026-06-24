vpc_name        = "eks-vpc"
vpc_cidr        = "30.0.0.0/16"
region          = "ap-south-1"
aws_profile     = "default"
cluster_name    = "eks_cluster"
node_group_name = "eks_node_group"
instance_type   = "t3.large"

desired_size = 3
max_size     = 6
min_size     = 3


public_subnet_cidrs = [
  "30.0.1.0/24",
  "30.0.2.0/24",
  "30.0.3.0/24"
]
private_subnet_cidrs = [
  "30.0.4.0/24",
  "30.0.5.0/24",
  "30.0.6.0/24"
]
availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]