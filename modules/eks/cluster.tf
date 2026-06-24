resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
  #aws_profile = var.aws_profile
  region = var.region
  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.33"

  vpc_config {
    #subnet_ids = var.public_subnet_cids + var.private_subnet_cids
    subnet_ids = var.private_subnet_cids
    endpoint_public_access = true
    endpoint_private_access = true

     public_access_cidrs = [
      "0.0.0.0/0"
    ]
    
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
  ]
}