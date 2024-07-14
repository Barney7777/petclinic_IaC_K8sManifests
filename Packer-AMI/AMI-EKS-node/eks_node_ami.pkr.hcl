# packer plugin for AWS
packer {
  required_plugins {
    amazon = {
      version = " >= 1.3.0 "
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the based and where to save it
source "amazon-ebs" "eks_worker_node_ami" {
  region             = var.region
  instance_type      = var.instance_type
  ami_name           = "eks-worker-node-ami-${formatdate("YYYY-MM-DD-hh-mm", timestamp())}"
  source_ami         = var.source_ami
  ssh_username       = var.ssh_username
  security_group_ids = var.security_group_ids
  # ami_users = ["AWS_Account_ID"]
  ami_regions = var.ami_regions
}

# build process
build {
  name = var.ami_name
  sources = [
    "source.amazon-ebs.eks_worker_node_ami"
  ]

  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo chmod +x /tmp/provisioner.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "/tmp/provisioner.sh"
    ]
  }
}