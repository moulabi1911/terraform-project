#this file consists of code for instances and sg
provider "aws" {
region = "eu-west-1"
}

resource "aws_instance" "abc" {
  ami             = "ami-014a5028b0bf7f64f"
  instance_type   = "t2.medium"
  key_name        = "bee"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is moulabi, here im doing terraform infrastructure server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "pqr" {
  ami             = "ami-014a5028b0bf7f64f"
  instance_type   = "t2.medium"
  key_name        = "bee"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is moulabi here im doing terraform infrastructure server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "123" {
  ami             = "ami-014a5028b0bf7f64f"
  instance_type   = "t2.medium"
  key_name        = "bee"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-1a"
  tags = {
    Name = "appserver-1"
  }
}

resource "aws_instance" "456" {
  ami             = "ami-014a5028b0bf7f64f"
  instance_type   = "t2.medium"
  key_name        = "bee"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-1b"
  tags = {
    Name = "appserver-2"
  }
}

resource "aws_security_group" "one" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "buck" {
  bucket = "moulabidevops19"
}

resource "aws_iam_user" "two" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "creating users"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "three" {
 availability_zone = "eu-west-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
