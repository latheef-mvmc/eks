resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-cluster-sg"
  }
}
# Security group for EKS worker nodes
resource "aws_security_group" "eks_node_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-node-sg"
  }
}

#rules for EKS cluster security group
resource "aws_security_group_rule" "eks_cluster_to_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_node_sg.id
}



resource "aws_security_group_rule" "cluster_egress_all" {
    type                     = "egress"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    cidr_blocks              = ["0.0.0.0/0"]
    security_group_id        = aws_security_group.eks_cluster_sg.id
    description              = "Allow all outbound traffic from the cluster"
}

########
# resource "aws_security_group_rule" "eks_node_to_cluster" {
#   type                     = "egress"
#   from_port                = 0
#   to_port                  = 65535
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks_node_sg.id
#   destination_security_group_id = aws_security_group.eks_cluster_sg.id
# }

resource "aws_security_group_rule" "node_egress_all" {
    type                     = "egress"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    cidr_blocks              = ["0.0.0.0/0"]
    security_group_id        = aws_security_group.eks_node_sg.id
    description              = "Allow all inbound traffic to worker nodes"
    }
  
