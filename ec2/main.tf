data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.example.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = var.component
    }
    
    provisioner "remote-exec" {
        
        connection {
            host = self.public_ip
            user = "centos"
            password = "DevOps321"
        }
        
        inline = [
        "git clone https://github.com/Preetam6126/roboshop-shell",
        "cd roboshop-shell",
        "sudo bash ${var.component}.sh"
        ]
    }
}

resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}sg"
  description = "Allow TLS inbound traffic"
  

  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.dev}-sg"
  }
}


resource "aws_route53_record" "record" {
  zone_id = "Z099042325KVJ8P6CC8JI"
  name    = "${var.component}-dev.devops36.shop"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

variable "component" {}
variable "instance_type" {}

variable "env" {
    default = "dev"
}


