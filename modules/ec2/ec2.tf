resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion_ssh.id
  subnet_id                   = var.public_subnet[0]
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  user_data                   = <<EOF
#!/bin/bash

apt update
apt install ansible -y
EOF

  tags = {
    "Name" : "bastion"
  }
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name               = aws_key_pair.bastion_ssh.id
  subnet_id              = var.private_subnet[0]
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]

  tags = {
    "Name" : "mongodb"
  }
}

