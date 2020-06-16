
#cidr_block: 10.0.0.0/16 allows you to use the IP address that start with “10.0.X.X”. There are 65,536 IP addresses are ready to use.

resource "aws_vpc" "vpc_main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true #gives you an internal domain name
  enable_dns_hostnames = true #gives you an internal host name
  enable_classiclink   = false
  instance_tenancy     = "default"
}

#cidr_block: 10.0.1.0/24. We have 254 IP addresses in this subnet
resource "aws_subnet" "subnet_for_webservers" {
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = "10.0.1.0/16"
  map_public_ip_on_launch = true //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Subnet for Webservers"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_main.id
}

#Create a custom route table for public subnet. public subnet can reach to the internet by using this.

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0" //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.gw.id
  }

}

# Associate CRT and Subnet

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.subnet_for_webservers.id
  route_table_id = aws_route_table.prod-public-crt.id
}

resource "aws_security_group" "allow_port_80" {
  name        = "allow_port_80"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_main.id
  ingress {
    # TLS (change to whatever ports you need)
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # add a CIDR block here
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }

}



resource "aws_security_group" "allow_port_22" {
  name        = "allow_port_22"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_main.id
  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # add a CIDR block here
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }

}
