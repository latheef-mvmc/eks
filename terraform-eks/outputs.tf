output "efs_id" {
  value = module.efs.efs_file_system_id
}

output "efs_dns_name" {
  value = module.efs.efs_dns_name
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "worker_node_private_ips" {

  value = data.aws_instances.eks_nodes.private_ips
}

