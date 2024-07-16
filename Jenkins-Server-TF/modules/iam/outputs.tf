# export iam instance profile
output "iam_instance_profile" {
    value = aws_iam_instance_profile.ec2_instance_profile.name
}