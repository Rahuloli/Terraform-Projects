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

resource "aws_instance" "servers"{
    for_each = var.ec2_instances

    ami = each.value.ami
    instance_type = each.value.instance_type
    security_groups = [aws_security_group.ssh_sg.name]
    
}
