# EKS Control Plane Security Group
resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-cluster-sg"
  }
}


# EKS Worker Node Security Group
resource "aws_security_group" "eks_node_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-node-sg"
  }
}


###################################
# EKS Cluster Security Group Rules
###################################

# Worker Nodes -> EKS API Server
resource "aws_security_group_rule" "cluster_https_from_nodes" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_node_sg.id

  description = "Allow worker nodes to access EKS API"
}


# Control Plane outbound
resource "aws_security_group_rule" "cluster_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.eks_cluster_sg.id

  description = "Allow all outbound traffic"
}


###################################
# EKS Worker Node Security Rules
###################################

# Node-to-Node communication
resource "aws_security_group_rule" "node_to_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"

  security_group_id        = aws_security_group.eks_node_sg.id
  source_security_group_id = aws_security_group.eks_node_sg.id

  description = "Allow communication between EKS worker nodes"
}


# SSH from your laptop
resource "aws_security_group_rule" "node_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.eks_node_sg.id

  description = "SSH access to EKS worker nodes"
}


# ICMP Ping from your laptop
resource "aws_security_group_rule" "node_icmp" {
  type      = "ingress"
  from_port = -1
  to_port   = -1
  protocol  = "icmp"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.eks_node_sg.id

  description = "Allow ICMP ping to EKS worker nodes"
}


# Worker Node outbound access
resource "aws_security_group_rule" "node_egress_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.eks_node_sg.id

  description = "Allow worker nodes outbound traffic"
}

resource "aws_security_group_rule" "cluster_to_nodes" {

  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"

  security_group_id        = aws_security_group.eks_node_sg.id

  source_security_group_id = aws_security_group.eks_cluster_sg.id

  description = "Allow EKS control plane to communicate with worker nodes"
}




# resource "aws_security_group" "eks_cluster_sg" {
#   name        = "${var.cluster_name}-cluster-sg"
#   description = "Security group for EKS cluster control plane"
#   vpc_id      = var.vpc_id

#   tags = {
#     Name = "${var.cluster_name}-cluster-sg"
#   }
# }
# # Security group for EKS worker nodes
# resource "aws_security_group" "eks_node_sg" {
#   name        = "${var.cluster_name}-node-sg"
#   description = "Security group for EKS worker nodes"
#   vpc_id      = var.vpc_id

#   tags = {
#     Name = "${var.cluster_name}-node-sg"
#   }
# }

# resource "aws_security_group_rule" "node_to_node" {
#   type                     = "ingress"
#   from_port                = 0
#   to_port                  = 65535
#   protocol                 = "-1"

#   security_group_id        = aws_security_group.eks_node_sg.id
#   source_security_group_id = aws_security_group.eks_node_sg.id

#   description = "Allow communication between worker nodes"
# }

# resource "aws_security_group_rule" "cluster_https_from_nodes" {
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"

#   security_group_id        = aws_security_group.eks_cluster_sg.id
#   source_security_group_id = aws_security_group.eks_node_sg.id

#   description = "Worker nodes access Kubernetes API"
# }


# resource "aws_security_group_rule" "cluster_egress_all" {
#     type                     = "egress"
#     from_port                = 0
#     to_port                  = 0
#     protocol                 = "-1"
#     cidr_blocks              = ["0.0.0.0/0"]
#     security_group_id        = aws_security_group.eks_cluster_sg.id
#     description              = "Allow all outbound traffic from the cluster"
# }


# resource "aws_security_group_rule" "node_egress_all" {
#     type                     = "egress"
#     from_port                = 0
#     to_port                  = 0
#     protocol                 = "-1"
#     cidr_blocks              = ["0.0.0.0/0"]
#     security_group_id        = aws_security_group.eks_node_sg.id
#     description              = "Allow all inbound traffic to worker nodes"
#     }
  
