resource "aws_ecr_repository" "artifactory" {
  name                 = "jfrog/artifactory-pro"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    provisioned_by = "terraform"
  }
}

resource "aws_ecr_repository" "ubi" {
  name                 = "redhat/ubi9"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    provisioned_by = "terraform"
  }
}