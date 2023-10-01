# Artifactory-AWS-infrastructure

This Github page was designed to build a simple AWS infrastructure for Artifactory to run on Kubernetes, while having most of the resources provisioned by Terraform. 
The Infra stack that we will create will be an S3 bucket as a storage solution for Artifactory, RDS Postgresql as a database solution, two private ECR's to host Artifactory and UBI9 InitContainer images, and iAM roles and policies needed for all of them, including for AWS Load Balancer Controller. The controller itself however will be installed using Helm.

NOTE: This repo is not maintained by JFrog.

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

Make sure that you check all of the modules, and replace any values needed. Further instructions are included in the README for each module's directory. 
Once you finish adding the paramaters you need, create the resources using Terraform init and apply:

```
terraform init
```
```
terraform apply
```

## Helm details:

We are using Helm for Artifactory, and Nginx Ingress controller, which we need to use so the Ingress can have it's LB provisioned by AWS Load balancer controller. We will be using JFrog's Artifactory Helm chart, and I included a values.yaml which has all of the necessary values to use in correlation with the AWS Infra that we will create, such as S3 and RDS.

Each chart will contain further details on each of it's README.
