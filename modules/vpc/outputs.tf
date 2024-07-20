# export the vpc id
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# export the public subnet az1 id
output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}