data "tls_certificate" "eks" {
  url = local.oidc_issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = local.oidc_issuer
}

// Run the following command to generate the URL - aws eks describe-cluster --name your-cluster-name --query "cluster.identity.oidc.issuer"
locals {
  oidc_issuer = "https://oidc.eks.eu-central-1.amazonaws.com/id/YOUR-ID"
}
