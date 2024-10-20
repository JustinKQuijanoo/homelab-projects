### 
# Author: Justin Quijano
###

# output for public and private subnet IDs to be used for ec2-instances module in the root main.tf
output "public_subnet_id" {
  value = aws_subnet.SN-Pub-Hydrohomie.id 
}

output "private_subnet_id" {
  value = aws_subnet.SN-Priv-Hydrohomie.id 
}

# Output for VPC ID to be used for security-group module in the root main.tf
output "vpc_id" {
  value = aws_vpc.VPC-Hydrohomie.id 
}
