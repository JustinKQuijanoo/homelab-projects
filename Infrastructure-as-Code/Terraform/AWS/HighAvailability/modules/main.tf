###
# Author: Justin Quijano
###

# Module for VPC
module "vpc" {
  source         = "./vpc"
  aws_region     = "us-east-1"
  vpc_name       = "VPC-Hydrohomie"
  cidr_block     = "172.16.0.0/16"
  public_subnet  = "172.16.0.0/24"
  private_subnet = "172.16.1.0/24"
}

# Module for security groups
module "security-group" {
  source = "./security-group/"
  vpc_id = module.vpc.vpc_id
}

# Module for load balancers
module "load-balancer" {
  source            = "./load-balancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security-group.security_group_id
}

# Module for ec2 instances
module "ec2-instances" {
  source = "./ec2-instances"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security-group.security_group_id
}
