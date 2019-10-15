provider "aws" {
 access_key ="${var.access_key}"
 secret_key ="${var.secret_key}"
 region ="${var.region}"
}

resource "aws_instance" "ss" {
    ami ="ami-0b69ea66ff7391e80"
    count ="2"
    instance_type ="t2.micro"
    subnet_id = "${var.subnet_id}"
    key_name = "${var.key_name}"
    tags =  {
        Name = "ss1"
        owner = "sai"
        purpose ="test"
    }

provisioner "local-exec" {
   command = "yum update -y"
 }
 }
