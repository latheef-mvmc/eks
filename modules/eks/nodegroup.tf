resource "aws_eks_node_group" "eks_node_group" {

  cluster_name    = aws_eks_cluster.eks_cluster.name

  node_group_name = var.node_group_name

  node_role_arn = aws_iam_role.eks_node_role.arn

  subnet_ids = var.private_subnet_cids

  capacity_type = "ON_DEMAND"
   
  instance_types = [
    var.instance_type
  ]

  launch_template {

    id = aws_launch_template.eks_node_lt.id

    version = "$Latest"
  }

  scaling_config {

    desired_size = var.desired_size

    min_size = var.min_size

    max_size = var.max_size
  }

  update_config {

    max_unavailable = 1
  }

  depends_on = [

    aws_iam_role_policy_attachment.worker_node_policy,

    aws_iam_role_policy_attachment.worker_cni_policy,

    aws_iam_role_policy_attachment.ecr_read_policy,

    aws_eks_cluster.eks_cluster
  ]

  tags = {

    Name = "${var.cluster_name}-node-group"

  }
}



# resource "aws_eks_node_group" "eks_node_group" {
#   cluster_name    = var.cluster_name
#   node_group_name = var.node_group_name
#   node_role_arn   =  aws_iam_role.eks_node_role.arn
#   subnet_ids      = var.private_subnet_cids
#   #vpc_security_group_ids = [var.node_security_group_id]
  
                            
                    
# # launch_template {
# #      id      = aws_launch_template.eks_launch_template.id
# #      version = "$Latest"
# #    }
# instance_types   = [var.instance_type]
#   scaling_config {
#     desired_size = var.desired_size
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.worker_node_policy,
#     aws_iam_role_policy_attachment.worker_cni_policy,
#     #aws_iam_role_policy_attachment.worker_ec2_container_registry_readonly,
#     aws_eks_cluster.eks_cluster
#   ]
#   tags = {
#     Name = "${var.cluster_name}-node-group"
#   }
# }



