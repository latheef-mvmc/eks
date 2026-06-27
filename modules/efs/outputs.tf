output "efs_file_system_id" {
  value = aws_efs_file_system.efs.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.efs.dns_name
}

output "efs_mount_target_ids" {
  value = aws_efs_mount_target.efs_mt[*].id
}

output "efs_mount_target_ips" {
  value = aws_efs_mount_target.efs_mt[*].ip_address
}
output "efs_mount_target_subnet_ids" {
  value = aws_efs_mount_target.efs_mt[*].subnet_id
}

output "efs_security_group_id" {
  value = aws_security_group.efs_sg.id
}
