resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   =  aws_iam_role.eks_node_role.arn
  subnet_ids      = var.private_subnet_cids

instance_types   = [var.instance_type]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.worker_cni_policy,
    #aws_iam_role_policy_attachment.worker_ec2_container_registry_readonly,
    aws_eks_cluster.eks_cluster
  ]
  tags = {
    Name = "${var.cluster_name}-node-group"
  }
}