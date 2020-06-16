#This file create a EC2 instante and run a remote-exec

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_instance" "master" {
  ami                         = var.image_id
  instance_type               = var.instance_type_master
  subnet_id                   = aws_subnet.subnet_for_webservers.id
  #vpc_security_group_ids      = [aws_security_group.allow_port_22.id, aws_security_group.allow_port_80.id]
  vpc_security_group_ids      = [aws_security_group.allow_port_22.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_pair_key.key_name
  #depends_on             = [aws_internet_gateway.gw]

     connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/aws")
    host        = self.public_ip
  }

  
  provisioner "remote-exec" {
    inline = [
      "cat /etc/lsb-release"
    ]
  }
}

resource "aws_instance" "worker_1" {
  ami                         = var.image_id
  instance_type               = var.instance_type_workers
  subnet_id                   = aws_subnet.subnet_for_webservers.id
  #vpc_security_group_ids      = [aws_security_group.allow_port_22.id, aws_security_group.allow_port_80.id]
  vpc_security_group_ids      = [aws_security_group.allow_port_22.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_pair_key.key_name
  #depends_on             = [aws_internet_gateway.gw]

     connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/aws")
    host        = self.public_ip
  }

  
  provisioner "remote-exec" {
    inline = [
      "cat /etc/lsb-release"
    ]
  }
}

resource "aws_instance" "worker_2" {
  ami                         = var.image_id
  instance_type               = var.instance_type_workers
  subnet_id                   = aws_subnet.subnet_for_webservers.id
  #vpc_security_group_ids      = [aws_security_group.allow_port_22.id, aws_security_group.allow_port_80.id]
  vpc_security_group_ids      = [aws_security_group.allow_port_22.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_pair_key.key_name
  #depends_on             = [aws_internet_gateway.gw]

     connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/aws")
    host        = self.public_ip
  }

  
  provisioner "remote-exec" {
    inline = [
      "cat /etc/lsb-release"
    ]
  }
}
