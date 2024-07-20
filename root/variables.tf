# environment Variables
variable "project_name" {}
variable "environment" {}

# vpc variables
variable "vpc_cidr" {}
variable "region" {}
variable "public_subnet_az1_cidr" {}

# Security group variables
variable "ssh_location" {}

# ec2 variables
variable "instance_type" {}
variable "key_name" {}
variable "instance_name" {}
variable "ami_id" {}
