# create iam policy
resource "aws_iam_policy" "ec2_instance_policy" {
  name = "${var.project_name}-${var.environment}-jenkins-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeImages",
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "ec2:DescribeSnapshots",
          "ec2:DescribeSubnets",
          "ec2:DescribeTags",
          "ec2:DescribeVpcs",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:RegisterImage",
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:ModifyImageAttribute",
          "ec2:ModifyInstanceAttribute",
          "ec2:ResetImageAttribute",
          "ec2:RunInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:CreateKeyPair",
          "ec2:DeleteKeyPair",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeSecurityGroups",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

# Create the IAM role
resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.project_name}-${var.environment}-jenkins-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "jenkins_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.ec2_instance_policy.arn
}

# Create an IAM instance profile and associate it with the IAM role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-${var.environment}-ec2_instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}
