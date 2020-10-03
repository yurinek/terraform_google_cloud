# terraform_google_cloud

The goals of this project are to automatically create virtual machines, networks, subnets, private and public ips, firewall rules, persistent disks, buckets and Kubernetes Cluster in Google Cloud.<br><br>

The project is devided into 3 parts:<br><br>

gcp_prove_of_concept        -   creation of all the resource objects mentioned above<br>
gcp_modules_from_registry   -   example usage of existing Terraform modules from registry <br>
gcp_own_module              -   example creation of an own module<br>

## How to install:

git clone this project.<br>
change directory to one of 3 directories.<br>
create a gcp bucket for remote storage of the state file.

```hcl
$ gsutil mb -l eu -p your-gcp-project-name gs://your-bucket-name
$ gsutil versioning set on gs://your-bucket-name
$ export GOOGLE_APPLICATION_CREDENTIALS="path-to-your-google-cloud-authentification-file.json"
```
make sure to create a gcp auth file for the above environment variable. 


## How to run:

```hcl
#init module
$ terraform init

# check for config errors
$ terraform validate

# preview
$ terraform plan 

#If everything looks correct and you are ready to build the infrastructure, apply the template in Terraform:
$ terraform apply 

$ terraform output ip

# in case ips are not generated yet
$ sleep 1
$ terraform refresh

# connect to created vm
$ ssh $(terraform output ip)

# to remove all created resources
$ terraform destroy 
```

