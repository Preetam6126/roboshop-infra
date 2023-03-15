module "ec2" {
    for_each = var.instances
    source = "./ec2"
    component = each.value["name"]
    instance_type = each.value["type"]
    env           = var.env
    ## below password is used during terraform practice but we manage passwords with ansible 
  ##  password = try(each.value["password"], "null") 
  
    
}

