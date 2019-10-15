provider "aws" {
 access_key ="AKIAYLLDGX6MU66R4TM4"
 secret_key ="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"
 region ="us-east-1"
}

resource "aws_instance" "ss" {
    ami ="ami-0b69ea66ff7391e80"
    count ="2"
    instance_type ="t2.micro"
    subnet_id = "subnet-06514c363477b9d8b"
    key_name = "VDW"
    tags =  {
        Name = "ss1"
        owner = "sai"
        purpose ="test"
    }

provisioner "local-exec" {
   command = "yum update -y"
 }

}
