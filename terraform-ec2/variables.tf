variable "aws_region" {
    description = "Region to deploy services"
    type = string
    default = "us-west-2"
}

variable "ec2_instances" {
    description = "Map of ec2 instances"
    type = map(object({
        ami = string
        instance_type = string 
        key_pair_name = string
    }))

}