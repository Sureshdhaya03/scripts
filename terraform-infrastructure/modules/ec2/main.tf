data "aws_ami" "amazon_linux" {
    owners = ["amazon"]
    most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}  

resource "aws_security_group" "sg_group" {
  name        = "Group_copy"
  description = "Allow TLS inbound traffic"
  

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
    
  }
  ingress {
    description      = "TLS from VPC"
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
    
  }

  tags = {
    Name = "Group_001"
  }
}

resource "aws_instance" "webserver-007" {
  count = var.instance_count
  instance_type = var.instance_type
  ami =data.aws_ami.amazon_linux.id
  iam_instance_profile =var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.sg_group.id]
  key_name = var.key_name
  tags = {

    Name = var.instance_name
   }
 
  user_data = <<EOF
    #!/bin/bash
  exec 1 > home/ec2-user/log1.log
  exec 2>&1
  cd home/ec2-user
  sudo yum update -y
  sudo yum install python3
  sudo pip3 install boto3
  aws s3 cp s3://md5-bucket-007/python_script/python_md5.py python_md5.py
  python3 python_md5.py
  EOF
}

  
  

  