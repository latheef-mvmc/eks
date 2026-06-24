resource "aws_launch_template" "eks_node_lt" {

  name_prefix = "${var.cluster_name}-node-"
  #image_id = var.ami_id

  # vpc_security_group_ids = [
  #   var.node_security_group_id
  # ]

  #key_name = var.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-worker-node"
      Evnvironment = "production"
      Project = "ursaminor"
      owner = "carphone-warehouse"
    }
  }

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = 30

      volume_type = "gp3"

      encrypted = true

      delete_on_termination = true
    }
  }

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

  }

  tags = {

    Name = "${var.cluster_name}-launch-template"

  }
}