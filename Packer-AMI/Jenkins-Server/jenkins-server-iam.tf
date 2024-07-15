# create iam policy document. this policy allows the jenkins  server to assume a role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create the IAM role using the policy document defined in the data source
resource "aws_iam_role" "ec2_instance_role" {
  name               = "${var.project_name}-${var.environment}-ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Attach the AWS managed policy (AdministratorAccess) to the IAM role
resource "aws_iam_role_policy_attachment" "ec2_instance_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# create and Attach a Custom Policy
resource "aws_iam_policy" "pass_role_policy" {
  name = "${var.project_name}-${var.environment}-pass-role-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "pass_role_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.pass_role_policy.arn
}

# Create an IAM instance profile and associate it with the IAM role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}
# # create iam policy
# resource "aws_iam_policy" "ec2_instance_policy" {
#   name = "${var.project_name}-${var.environment}-jenkins-policy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ec2:DescribeImages",
#           "ec2:DescribeInstances",
#           "ec2:DescribeRegions",
#           "ec2:DescribeSnapshots",
#           "ec2:DescribeSubnets",
#           "ec2:DescribeTags",
#           "ec2:DescribeVpcs",
#           "ec2:CreateTags",
#           "ec2:DeleteTags",
#           "ec2:RegisterImage",
#           "ec2:CreateVolume",
#           "ec2:AttachVolume",
#           "ec2:DeleteVolume",
#           "ec2:ModifyImageAttribute",
#           "ec2:ModifyInstanceAttribute",
#           "ec2:ResetImageAttribute",
#           "ec2:RunInstances",
#           "ec2:StopInstances",
#           "ec2:TerminateInstances",
#           "ec2:CreateKeyPair",
#           "ec2:DeleteKeyPair",
#           "ec2:DescribeKeyPairs",
#           "ec2:DescribeSecurityGroups",
#           "ec2:CreateImage",
#           "ec2:DescribeNetworkInterfaces",
#           "ec2:AttachNetworkInterface",
#           "ec2:DetachNetworkInterface",
#           "ec2:CreateNetworkInterface",
#           "ec2:DeleteNetworkInterface",
#           "iam:PassRole"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# # Create the IAM role
# resource "aws_iam_role" "ec2_instance_role" {
#   name = "${var.project_name}-${var.environment}-jenkins-execution-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # Attach the policy to the IAM role
# resource "aws_iam_role_policy_attachment" "jenkins_policy_attachment" {
#   role       = aws_iam_role.ec2_instance_role.name
#   policy_arn = aws_iam_policy.ec2_instance_policy.arn
# }

# # Create an IAM instance profile and associate it with the IAM role
# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "${var.project_name}-${var.environment}-ec2_instance-profile"
#   role = aws_iam_role.ec2_instance_role.name
# }
