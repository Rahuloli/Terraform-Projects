ec2_instances = {

    appserver = {

    instance_type = "t2.micro"
    ami = "ami-075686beab831bb7f"
    key_pair_name = "appserver-key"

    },

    dbserver = {

    instance_type = "t2.micro"
    ami = "ami-03f8acd418785369b"
    key_pair_name = "dbserver-key"

    }


}