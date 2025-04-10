resource "tls_private_key" "ec2_keys"{
    for_each = var.ec2_instances

    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "ec2_keys" {
    for_each = var.ec2_instances 
    key_name   = each.value.key_pair_name
    public_key = tls_private_key.ec2_keys[each.key].public_key_openssh
}

resource "aws_security_group" "ssh_sg"{
    name = "allow-ssh"
    description = "allows users to connect to ec2 instances using ssh"
    vpc_id = data.aws_vpc.default.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

}

data "aws_vpc" "default"{
    default = true
}

resource "aws_instance" "servers" {
  for_each = var.ec2_instances

  ami               = each.value.ami
  instance_type     = each.value.instance_type
  key_name          = aws_key_pair.ec2_keys[each.key].key_name
  security_groups   = [aws_security_group.ssh_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = each.key
  }
}

resource "local_file" "private_keys" {
  for_each = var.ec2_instances

  content              = tls_private_key.ec2_keys[each.key].private_key_pem
  filename             = "${path.module}/generated_keys/${each.value.key_pair_name}.pem"
  file_permission      = "0400"
}

