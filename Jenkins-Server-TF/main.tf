# store these variables as local variables coz we will use these variable through project
locals {
  project_name = var.project_name
  environment  = var.environment
}

# Create vpc
module "vpc" {
  source                 = "./modules/vpc"
  project_name           = local.project_name
  environment            = local.environment
  region                 = var.region
  vpc_cidr               = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
}

# Create security-groups
module "security_group" {
  source       = "./modules/security-groups"
  project_name = local.project_name
  environment  = local.environment
  vpc_id       = module.vpc.vpc_id
  ssh_location = var.ssh_location
}

# Create ec2 iam
module "iam" {
  source       = "./modules/iam"
  project_name = local.project_name
  environment  = local.environment
}

# Create jenkins server
module "ec2" {
  source                    = "./modules/ec2"
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  jenkins_security_group_id = [module.security_group.jenkins_security_group_id]
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  iam_instance_profile      = module.iam.iam_instance_profile
  instance_name             = var.instance_name
}