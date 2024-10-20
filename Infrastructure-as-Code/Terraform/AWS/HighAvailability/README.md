# HighAvailability ReadMe

## Topology
![AWS HA Topology](./images/aws_topology.png)

Contains the Terraform code to create a high availability infrastructure.
Creates the following:
- 1 VPC
- 2 Subnets (1 public production, 1 private development)
- 4 EC2 instances (2 webservers, 2 databases, 1)
