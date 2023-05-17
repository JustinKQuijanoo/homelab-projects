###
# Author: Justin Quijano
# Description: Contains the code to create 1 VPC
#
###

# Create a VPC block
resource "aws_vpc" "VPC-Hydrohomie" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "VPC-Hydrohomie" }
}

# Create internet gateway
resource "aws_internet_gateway" "IGW-Hydrohomie" {
  vpc_id = aws_vpc.VPC-Hydrohomie.id
  tags   = { Name = "IGW-Hydrohomie" }
}

# Create a public subnet
resource "aws_subnet" "SN-Pub-Hydrohomie" {
  vpc_id                  = aws_vpc.VPC-Hydrohomie.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags                    = { Name = "SN-Pub-Hydrohomie" }
}

# Create public route table 
resource "aws_route_table" "RTB-Pub-Hydrohomie" {
  vpc_id = aws_vpc.VPC-Hydrohomie.id
  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.IGW-Hydrohomie.id
  }
  tags = { Name = "RTB-Pub-Hydrohomie" }
}

# Create a private subnet
resource "aws_subnet" "SN-Priv-Hydrohomie" {
  vpc_id            = aws_vpc.VPC-Hydrohomie.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1b"
  tags              = { Name = "SN-Priv-Hydrohomie" }
}

# Create private route table 
resource "aws_route_table" "RTB-Priv-Hydrohomie" {
  vpc_id = aws_vpc.VPC-Hydrohomie.id
  route {
    cidr_block = var.default_route
    gateway_id = aws_nat_gateway.NAT-Hydrohomie.id
  }
  tags = { Name = "RTB-Priv-Hydrohomie" }
}

# Associate the public subnet and the public route table 
resource "aws_route_table_association" "public-access" {
  subnet_id      = aws_subnet.SN-Pub-Hydrohomie.id
  route_table_id = aws_route_table.RTB-Pub-Hydrohomie.id
}

# Associate the private subnet and the private route table 
resource "aws_route_table_association" "private-access" {
  subnet_id      = aws_subnet.SN-Priv-Hydrohomie.id
  route_table_id = aws_route_table.RTB-Priv-Hydrohomie.id
}

# Create Elastic IP for Private Hydrohomie Subnet
resource "aws_eip" "EIP-NAT-Hydrohomie" {
  vpc = true
}

# Create NAT Gateway for Public Hydrohomie Subnet
resource "aws_nat_gateway" "NAT-Hydrohomie" {
  allocation_id = aws_eip.EIP-NAT-Hydrohomie.id
  subnet_id     = aws_subnet.SN-Pub-Hydrohomie.id
  tags          = { Name = "NAT-Hydrohomie" }
  depends_on = [
    aws_eip.EIP-NAT-Hydrohomie
  ]
}