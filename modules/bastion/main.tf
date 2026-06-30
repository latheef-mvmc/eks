resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = var.public_subnet_id

# user_data = <<-EOF
#               #!/bin/bash
#           sudo apt update -y
#               sudo apt install -y nfs-common.*
#           sudo    cat > /home/ubuntu/eks-key.pem <<'KEY'
#               ${file("${path.root}/eks-key.pem")}
#               KEY
#            sudo   chmod 400 /home/ubuntu/eks-key.pem
#               EOF
    provisioner "file" {

    source      = "${path.root}/eks-key.pem"
    destination = "/home/ubuntu/eks-key.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("${path.root}/eks-key.pem")
      timeout     = "3m"
    }
  }

  provisioner "remote-exec" {

    inline = [
      "chmod 400 /home/ubuntu/eks-key.pem"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("${path.root}/eks-key.pem")
    }
  }


  tags = {
    Name = var.bastion_name
  }
}

resource "aws_security_group" "bastion" {

  name   = "${var.bastion_name}-sg"
  vpc_id = var.vpc_id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }
egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }



# ICMP (Ping)
  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.bastion_name}-sg"
  }

}