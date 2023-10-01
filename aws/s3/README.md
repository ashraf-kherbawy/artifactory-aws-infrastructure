# S3 Bucket 

Artifactory utilises S3 as one of it's storage solutions, to store the binaries in. It is generally recommended over other methods when you have Artifactory hosted on a cloud, and is 
very stable overall.

The main Terraform file will create an S3 bucket, and also an iAM role with a policy attached containing full access to S3. While this is what was used for testing,
it's not necessary to use full permissions, and you can check the list for the needed permissions [here](https://jfrog.com/help/r/jfrog-installation-setup-documentation/set-up-artifactory-to-use-s3).

The iAM role's ARN will be used in the Helm chart to create a service account, so Artifactory can have access to S3.
