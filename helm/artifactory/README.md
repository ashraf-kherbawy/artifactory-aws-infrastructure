# Installing Artifactory's Helm Chart

The provided values.yaml is a good standard to start with, utilising most of the infrastructure we have created. 

## Using S3's direct upload binary provider

Now that we have created the S3 bucket, we specified in the values.yaml to use ```artifactory.persistence.type=s3-storage-v3-direct```, which will tell the chart
to create the [binarystore.xml](https://jfrog.com/help/r/jfrog-installation-setup-documentation/filestore-configuration) file, and then under ```artifactory.persistence.awsS3V3```, we specify
the required paramaters.

## Creating a service account containing the S3's role ARN:

The chart provides us the option to for it to create and manage a service account, which we can use to attach the S3's role ARN, to allow Artifactory inside the pod, to reach the S3 bucket.

To get the ARN of the role, run the following AWS CLI command:
```
aws iam get-role --role-name EKS-S3-POD-ROLE --query 'Role.Arn'
```
Then, specify the role in the annotation section under serviceAccount section:
```
serviceAccount:
  create: true
  annotations: 
    eks.amazonaws.com/role-arn: <EKS-S3-ROLE-ARN>
```

## Using ECR as the Helm's images registry

After creating two repositories in ECR, one being for Artifactory's image, and the other for Red Hat's UBI9 (For the initContainers), we define them in the values.yaml like the
following:

Artifactory's image:
```
artifactory:
  image:
    registry: ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com
    repository: jfrog/artifactory-pro
    tag: latest
```
UBI9's image:
```
initContainerImage: ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/redhat/ubi9:9.2.691
```
## Creating a secret which contains the database credentials 

You can pass the database credentials as plain text in your values.yaml under ```database.url```, ```database.user```, ```database.password```, but for security reasons that's not optimal.
Instead, we can create a secret passing containing the database credentials:
```
kubectl create secret generic -n main-lab rds-artifactory \
  --from-literal=db-user=artifactory \
  --from-literal=db-password=password \
  --from-literal=db-url=jdbc:postgresql://YOUR-RDS-ENDPOINT:5432/artifactory ## The format must be the exact same
```
And then pass them under the database section, alongside the "type" and "driver" (Refer to Artifactory's [database config doc](https://jfrog.com/help/r/jfrog-installation-setup-documentation/database-configuration) for more info on other databases):
```
database: 
  type: postgresql
  driver: org.postgresql.Driver
  secrets: 
    user:
      name: "rds-artifactory"
      key: "db-user"
    password:
      name: "rds-artifactory"
      key: "db-password"
    url:
      name: "rds-artifactory"
      key: "db-url"
```
Finally, since we are using our own managed external database, we must disable the default postgres that gets deployed by the chart:
```
postgresql:
  enabled: false
```
## Configuring the Ingress
After you install the Nginx Ingress controller (Or any other controller), Artifactory's chart can create a managed Ingress, with your provided configs, in the values.yaml we used this config:
```
ingress:
  enabled: true
  defaultBackend:
    enabled: true
  hosts:
    - "example.com"
  routerPath: /
  artifactoryPath: /artifactory/
  className: nginx
  annotations: 
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "2400"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "2400"
```
AWS Load Balancer Controller will provision an NLB in our context with the controller that we deployed. 
