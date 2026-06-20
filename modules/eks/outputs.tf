output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
output "cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}
output "node_group_name" {
  #value = aws_eks_node_group.eks_node_group.node_group_name
  value = aws_eks_node_group.eks_node_group.node_group_name
}