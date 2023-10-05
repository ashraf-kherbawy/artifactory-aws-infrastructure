# Private ECR 

While this is completely optional, if you prefer to opt out of using JFrog's official Docker registry (releases-docker.jfrog.io) for the Artifactory and UBI9 images, 
using a private ECR is a great alternative. 

Once you deploy all the modules with the main.tf, you will have two repos to save both images. 

## Deploying the images to the repos

Let's first pull the images. I will be using podman for the examples:
```
podman pull releases-docker.jfrog.io/ubi9/ubi-minimal:9.2.691
```
```
podman pull releases-docker.jfrog.io/jfrog/artifactory-pro:latest
```
Login into the repository:
```
aws ecr get-login-password --region eu-central-1 | podman login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com
```
Tag the images:
```
podman tag releases-docker.jfrog.io/ubi9/ubi-minimal:9.2.691 ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/redhat/ubi9:9.2.691
```
```
podman tag releases-docker.jfrog.io/jfrog/artifactory-pro:latest ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/jfrog/artifactory-pro:latest
```
And then finally, push the images:
```
podman push ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/redhat/ubi9:9.2.691
```
```
podman push ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/jfrog/artifactory-pro:latest
```
