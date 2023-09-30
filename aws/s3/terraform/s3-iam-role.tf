resource "aws_iam_role" "artifactory-s3-full-access" {
  name = "ashrafk-eks-pod-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::035274893828:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/8811D60987AA6FA9E658192D9BA01F14" // Replace with OIDC of your EKS
        },
        Condition = {
          StringEquals = {
            "oidc.eks.eu-central-1.amazonaws.com/id/8811D60987AA6FA9E658192D9BA01F14:aud": [ // Replace with OIDC of your EKS
                "sts.amazonaws.com"
            ]
          }
        }
      }
    ]
  })

  tags = {
    provisioned_by = "ashrafk-terraform"
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
