variable "ami_id" {
    description = "ami_id"
    type = string
}

variable "instance_type" {
    description = "instance_type"
    type = string
}

variable "key_name" {
    description = "key_name"
    type = string
}

variable "public_subnet_az1_id" {
    description = "subnet_id"
    type = string
}

variable "jenkins_security_group_id" {
  description = "security group for jenkins server"
  type = list
}

variable "iam_instance_profile" {
  description = "iam instance profile for jenkins server"
  type = string
}

variable "instance_name" {
    description = "Name of the instance"
    type = string
}