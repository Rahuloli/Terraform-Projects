variable "ec2_instances" {
    description = "Map of ec2 instances"
    type = map(object({
        ami = string
        instance_type = string 
    }))

}