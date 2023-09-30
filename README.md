# Artifactory-AWS-infrastructure

This Github page was designed to build a simple AWS infrastructure for Artifactory to run on Kubernetes, while having most of the resources provisioned by Terraform. 
The Infra stack that we will create will be an S3 bucket as a storage solution for Artifactory, RDS Postgresql as a database solution, two private ECR's to host Artifactory and UBI9 InitContainer images, and iAM roles and policies needed for all of them, including for AWS Load Balancer Controller. The controller itself however will be installed using Helm.

Prerequisites:

  1. EKS Cluster
  2. AWS Cli
  3. Terraform
  4. Helm

## Terraform details:

The main.tf file contains all of the following AWS modules:

  1. S3 Bucket and S3 iAM role
  2. Private ECR
  3. RDS
  4. AWS LBC iAM role and OIDC iAM role

