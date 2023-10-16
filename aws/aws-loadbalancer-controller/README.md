# AWS Load Balancer Controller 

For load balancer provisioning, I will be using AWS LBC, which will provision an ALB for the Ingress that the Artifactory chart creates. AWS LBC itself cannot be provionsed with Terraform, thus, you will need to install it (I used Helm option) by following the [official documentation](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/deploy/installation/).

## Load Balancer Controller iAM roles

Using Terraform, once you initiate the main.tf, it will also deploy the modules that exist in this directory, controller-iam.tf and oidc-iam.tf. These iAM roles and policies were designed 
using the [official documentation](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.6/deploy/installation/#configure-iam). Additionally, the AWSLoadBalancerController.json in the directory is used by the iAM policy.

Once the iAM roles are created, you can proceed with installing the LBC based on the documentation. Helm is a recommended method.
