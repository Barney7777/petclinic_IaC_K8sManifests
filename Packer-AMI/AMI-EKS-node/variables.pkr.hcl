variable "region" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "source_ami" {
    type = string
}

variable "ssh_username" {
    type = string
}

variable "security_group_ids" {
    type = list(string)
}

variable "ami_regions" {
    type = list(string)
}

variable "ami_name" {
    type = string
}

