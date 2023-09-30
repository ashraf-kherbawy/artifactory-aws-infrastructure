resource "aws_ecr_repository" "artifactory" {
  name                 = "ashrafk/jfrog/artifactory-pro"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    provisioned_by = "ashrafk-terraform"
  }
}

resource "aws_ecr_repository" "ubi" {
  name                 = "ashrafk/redhat/ubi9"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    provisioned_by = "ashrafk-terraform"
  }
}