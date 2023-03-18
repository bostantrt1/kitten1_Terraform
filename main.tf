terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "us-east-1"
}

resource "aws_instance" "kitten" {
  ami                     = "ami-006dcf34c09e50022"
  instance_type           = "t2.micro"
  vpc_security_group_ids = [aws_security_group.kitten1.id]
  key_name   = "xxxxxxxx"
  
  user_data = <<EOF
    #! /bin/bash
    yum update -y
    yum -y install wget
    yum install httpd -y
    FOLDER="https://raw.githubusercontent.com/bostantrt1/project-kitten/main/static-web"
    cd /var/www/html
    wget $FOLDER/index.html
    wget $FOLDER/cat0.jpg
    wget $FOLDER/cat1.jpg
    wget $FOLDER/cat2.jpg
    wget $FOLDER/cat3.png
    systemctl start httpd
    systemctl enable httpd
  EOF

}


resource "aws_security_group" "kitten1" {
  name        = "has1"
  description = "Allow ssh and http inbound traffic"
 

  ingress {
    description      = "ssh ."
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]
   
  }

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "has"
  }
}

output "kittenpublicip" {
    value = aws_instance.kitten.public_ip
}
