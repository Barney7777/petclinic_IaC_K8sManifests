# environment Variables

variable "project_name" {
  description = "project name"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

# Security group variables
variable "vpc_id" {
    description = "vpc_id"
    type = string
}

variable "ssh_location" {
  description = "ip address that can ssh into the serverr"
  type        = string
}