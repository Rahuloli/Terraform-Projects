output public_ips {
  value       = {
    for instance_key, ec2 in aws_instance.servers:
    instance_key => ec2.public_ip
  }
}
