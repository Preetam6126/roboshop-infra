locals {
#   Private Subnets
# private_subnets_ids = module.vpc.private_subnets

 # private_subnets_ids = { for k, v in module.vpc["main"].private_subnets : k => v.id }
 
 subnet_ids = {
 db  = tolist([module.vpc["main"].private_subnets["db-az1"].id,module.vpc["main"].private_subnets["db-az2"].id])
 app = tolist([module.vpc["main"].private_subnets["app-az1"].id,module.vpc["main"].private_subnets["app-az2"].id])
 web = tolist([module.vpc["main"].private_subnets["web-az1"].id,module.vpc["main"].private_subnets["web-az2"].id])
 public = tolist([module.vpc["main"].public_subnets["public-az1"].id,module.vpc["main"].public_subnets["public-az2"].id])
 }
 
 db_subnets_ids  = tolist([module.vpc["main"].private_subnets["db-az1"].id,module.vpc["main"].private_subnets["db-az2"].id])
 app_subnets_ids = tolist([module.vpc["main"].private_subnets["app-az1"].id,module.vpc["main"].private_subnets["app-az2"].id])
 web_subnets_ids = tolist([module.vpc["main"].private_subnets["web-az1"].id,module.vpc["main"].private_subnets["web-az2"].id])
 }
 
 

# output "private_subnets" {
    
#     value = aws_subnet.private_subnets
# }



# "app-az1" = {
#         "arn" = "arn:aws:ec2:us-east-1:598125288280:subnet/subnet-01b05da09124cbee1"
#         "assign_ipv6_address_on_creation" = false
#         "availability_zone" = "us-east-1a"
#         "availability_zone_id" = "use1-az1"
#         "cidr_block" = "10.0.4.0/24"
#         "customer_owned_ipv4_pool" = ""
#         "enable_dns64" = false
#         "enable_resource_name_dns_a_record_on_launch" = false
#         "enable_resource_name_dns_aaaa_record_on_launch" = false
#         "id" = "subnet-01b05da09124cbee1"
#         "ipv6_cidr_block" = ""
#         "ipv6_cidr_block_association_id" = ""
#         "ipv6_native" = false
#         "map_customer_owned_ip_on_launch" = false
#         "map_public_ip_on_launch" = false
#         "outpost_arn" = ""
#         "owner_id" = "598125288280"
#         "private_dns_hostname_type_on_launch" = "ip-name"
#         "tags" = tomap({
#           "Name" = "dev-app-az1"
#           "app_name" = "roboshop"
#           "bu_unit_name" = "ecommerce"
#           "cost_center" = "1001"
#           "owner" = "ecom_bu"
#         })