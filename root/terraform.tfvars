# environment Variables
project_name = "jenkins"
environment  = "dev"

# VPC variables
vpc_cidr               = "123.0.0.0/16"
public_subnet_az1_cidr = "123.0.0.0/24"
region                 = "ap-southeast-2"
# Security group variables
ssh_location = "0.0.0.0/0"

# EC2 variables
instance_type = "t2.large"
key_name      = "myec2key"
instance_name = "jenkins-master"
ami_id        = "ami-0c3c1ddc9f0fef237"