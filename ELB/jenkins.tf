provider "aws" {
 access_key ="${var.access_key}"
 secret_key ="${var.secret_key}"
 region ="${var.region}"
}

resource "aws_instance" "ss1" {
    ami ="ami-00c03f7f7f2ec15c3"
    instance_type ="t2.micro"
    subnet_id = "subnet-a55147cd"
    security_groups =["sg-6e140a0e"]
    key_name = "${var.key_name}"
    associate_public_ip_address = "true"
   # user_data = "${file("/root/123/script.sh")}"
    user_data = "${file("/root/elb/httpd.sh")}"
    tags =  {
        Name = "jenkins-2a"
    }
 }
resource "aws_instance" "ss2" {
    ami ="ami-00c03f7f7f2ec15c3"
    instance_type ="t2.micro"
    subnet_id = "subnet-8a3e72f0"
    security_groups =["sg-6e140a0e"]
    key_name = "${var.key_name}"
    associate_public_ip_address = "true"
   # user_data = "${file("/root/123/script.sh")}"
    user_data = "${file("/root/elb/httpd.sh")}"
    tags =  {
        Name = "jenkins-2b"
    }
 }

# Create a new load balancer
resource "aws_elb" "jenkins-elb" {
  name               = "jenkins-elb"
  availability_zones = ["us-east-2a", "us-east-2b"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

instances                   = ["${aws_instance.ss1.id}" ,"${aws_instance.ss2.id}"]
  cross_zone_load_balancing   = true
#  idle_timeout                = 400
#  connection_draining         = true
#  connection_draining_timeout = 400

  tags = {
    Name = "jenkins-terraform-elb"
  }
}
resource "aws_lb_target_group" "jenkins" {
  name     = "jenkins-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-7d4fa016"
}

resource "aws_lb_target_group_attachment" "test-jenkins" {
  target_group_arn = "${aws_lb_target_group.jenkins.arn}"
  target_id        = "${aws_instance.ss1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "test-jenkins1" {
  target_group_arn = "${aws_lb_target_group.jenkins.arn}"
  target_id        = "${aws_instance.ss2.id}"
  port             = 80
}

