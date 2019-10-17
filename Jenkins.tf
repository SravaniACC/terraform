provider "aws" {
 access_key ="${var.access_key}"
 secret_key ="${var.secret_key}"
 region ="${var.region}"
}

resource "aws_instance" "ss" {
    ami ="ami-0b69ea66ff7391e80"
    count ="1"
    instance_type ="t2.micro"
    subnet_id = "${var.subnet_id}"
    security_groups =["sg-03c85431d9e2b4e41"]
    key_name = "${var.key_name}"
    associate_public_ip_address = "true"
    user_data = "${file("/root/123/script.sh")}"
    tags =  {
        Name = "test"
    }
#provisioner "remote-exec" { #execute the command in remote ec2 instance
#inline = [
# "sudo mkdir -p /var/www/html/", #command to be executed in remote ec2 instance
# "sudo yum install -y httpd",
# "sudo service httpd start",
# "sudo usermod -a -G apache ec2-user",
# "sudo chown -R ec2-user:apache /var/www",
# ]
#  }
#connection {
#    type     = "ssh"
#    host = "self.public_ip"
#    user     = "ec2-user"
#    password = ""
#    private_key = "${file("~/.ssh/id_rsa")}"
#  }

 }
