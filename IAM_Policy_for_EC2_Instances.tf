# iam_policy.tf
resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
  description = "Allow EC2 full access"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF
}
