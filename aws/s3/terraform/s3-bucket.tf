resource "aws_s3_bucket" "artifactory_s3_bucket" {
  bucket = "ashrafk-artifactory-bucket"
  
  tags = {
    provisioned_by = "ashrafk-terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "artifactory_s3_ownership" {
  bucket = aws_s3_bucket.artifactory_s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "artifactory_s3_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.artifactory_s3_ownership]
  bucket = aws_s3_bucket.artifactory_s3_bucket.id
  acl    = "private"
}