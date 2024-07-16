resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_az1_id
  vpc_security_group_ids = var.jenkins_security_group_id
  iam_instance_profile   = var.iam_instance_profile
  root_block_device {
    volume_size = 50
  }
  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
}