terraform {
  backend "s3" {}
}



#commands to be remember 

#terraform init -backend-config env-dev/state.tfvars  ---> to initiate at backend to particular 

#terraform apply -auto-approve -var-file=env-dev/main.tfvars

# these parameters creates by terraform in aws_ssm_parameter, and these parameters will refer by ansible.