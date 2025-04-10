output "ec2_public_ips" {
  value = {
    for name, instance in aws_instance.servers :
    name => instance.public_ip
  }
}

output "private_keys" {
  sensitive = true
  value = {
    for name, key in local_file.private_keys :
    name => key.filename
  }
}
