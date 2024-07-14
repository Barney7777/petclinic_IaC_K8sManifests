resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  root_block_device {
    volume_size = 50
  }
  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
}