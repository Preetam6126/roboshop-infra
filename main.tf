module "ec2" {
    
    for_each = var.instances
    source = "./ec2"
    component = each.value["name"]
    intance_type = each.value["type"]
}