resource "aws_iam_role" "artifactory-s3-full-access" {
  name = "eks-pod-s3-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        Principal = {
          Federated = "<YOUR-EKS-OIDC>" // Replace with OIDC of your EKS
        },
        Condition = {
          StringEquals = {
            "<YOUR-EKS-OIDC>": [ // Replace with OIDC of your EKS
                "sts.amazonaws.com"
            ]
          }
        }
      }
    ]
  })

  tags = {
    provisioned_by = "terraform"
  }
}

resource "aws_iam_policy" "s3_full_access_policy" { 
  name        = "s3_full_access_policy"
  description = "Policy for full S3 access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
  role = aws_iam_role.artifactory-s3-full-access.name
}
