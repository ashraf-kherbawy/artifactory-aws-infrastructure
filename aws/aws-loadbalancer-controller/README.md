# AWS Load Balancer Controller 

For load balancer provisioning, I will be using AWS LBC, which will provision an ALB for the Ingress that the Artifactory chart creates.

## Load Balancer Controller iAM roles

Using Terraform, once you initiate the main.tf, it will also deploy the modules that exist in this directory, controller-iam.tf and oidc-iam.tf. These iAM roles and policies were designed 
using the [official documentation](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/deploy/installation/#configure-iam).

Once the iAM roles are created, you can proceed with installing the LBC based on the documentation. Helm is a recommended method.
