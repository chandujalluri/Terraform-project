provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA2KQG3KB2JLL7GI3Y"
  secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-03c4dbdfc36515b16"
  instance_type   = "t2.micro"
  key_name        = "terraf1"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-03c4dbdfc36515b16"
  instance_type   = "t2.micro"
  key_name        = "terraf1"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server2"
  }
}
resource "aws_security_group" "three" {
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

resource "aws_s3_bucket" "four" {
  bucket = "chandubucket2024"
}

resource "aws_iam_user" "five" {
name = "chanuser2024" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "ap-south-1b"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
