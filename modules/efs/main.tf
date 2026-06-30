
############################
# EFS Security Group
############################

resource "aws_security_group" "efs_sg" {

  name = "${var.cluster_name}-efs-sg"

  description = "Security Group for Amazon EFS"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-efs-sg"
  }
}

############################
# Allow NFS from EKS Worker Nodes
############################

resource "aws_security_group_rule" "efs_ingress" {

  type = "ingress"

  from_port = 2049

  to_port = 2049

  protocol = "tcp"

  security_group_id = aws_security_group.efs_sg.id

  source_security_group_id = var.eks_node_security_group_id

  description = "Allow NFS traffic from EKS worker nodes"

  # cidr_blocks = [
  #   "0.0.0.0/0"
  # ]
}

############################
# Egress
############################

resource "aws_security_group_rule" "efs_egress" {

  type = "egress"

  from_port = 0

  to_port = 0

  protocol = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.efs_sg.id
}



resource "aws_efs_file_system" "efs" {
  creation_token = var.efs_creation_token
  performance_mode = var.efs_performance_mode
  throughput_mode = var.efs_throughput_mode
  encrypted = var.efs_encrypted
  tags = {
    Name = var.efs_name
  }
}


############################
# Mount Targets
############################

resource "aws_efs_mount_target" "efs_mt" {

  count = length(var.private_subnet_cidrs)

  file_system_id = aws_efs_file_system.efs.id

  subnet_id = var.private_subnet_cidrs[count.index]

  security_groups = [
    aws_security_group.efs_sg.id
  ]
}




############################
# Backup Policy
############################

resource "aws_efs_backup_policy" "efs_backup" {

  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = "ENABLED"
  }
}

############################
# Lifecycle Policy
############################

# resource "aws_efs_file_system_lifecycle_policy" "efs_lifecycle" {

#   file_system_id = aws_efs_file_system.efs.id

#   transition_to_ia = "AFTER_30_DAYS"
# }