data "aws_caller_identity" "current" {}

data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "devops-practice-with-ansible"
  owners           = [data.aws_caller_identity.current.account_id]
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.example.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = var.component
    }
    
}

resource "null_resource" "provisioner" {
  provisioner "remote-exec" {
        
        connection {
            host = aws_instance.ec2.public_ip
            user = "centos"
            password = "DevOps321"
        }
        
        inline = [
          "ansible-pull -i localhost, -U https://github.com/Preetam6126/roboshop-ansible roboshop.yml -e role_name=${var.component}"   
        ]
        #below set is during terraform practice with hard code password
        # inline 
        # "git clone https://github.com/Preetam6126/roboshop-shell",
        # "cd roboshop-shell",
        # "sudo bash ${var.component}.sh ${var.password}"
        # ]
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
    Name = "${var.component}-${var.env}-sg"
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

##used in terraform
##variable "password" {}


