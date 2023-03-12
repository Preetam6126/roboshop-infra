terraform {
  backend "s3" {}
}

resource "aws_ssm_parameter" "parameter" {
  count = length(var.parameters)
  name  = var.parameters[count.index].name
  type  = var.parameters[count.index].type
  value = var.parameters[count.index].value
}

variable "parameters" {}


#commands to be remember 

#terraform init -backend-config env-dev/state.tfvars  ---> to initiate at backend to particular 

#terraform apply -auto-approve -var-file=env-dev/main.tfvars