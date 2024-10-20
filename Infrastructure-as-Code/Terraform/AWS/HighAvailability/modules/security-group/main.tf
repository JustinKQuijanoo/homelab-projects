### 
# Author: Justin Quijano
###

# Security group to allow SSH and HTTP
resource "aws_security_group" "SG-Hydrohomie" {
  name = "SG-Hydrohomie"
  description = "Allow SSH and HTTP"
  vpc_id = var.vpc_id
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow everything outbound"
    from_port = 0 
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




