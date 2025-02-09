module "vnet" {
  source = "./modules/networking/vnet"
  config = local.env.virtual-networks
}

module "security-groups" {
  source = "./modules/networking/nsg"
  config = local.env.security-groups
  depends_on = [module.vnet]
}

module "linux_vm" {
  source = "./modules/linux"
  config = local.env.vm
  depends_on = [module.security-groups]
}

module "nic" {
  source = "./modules/nic" 
  config = local.env.network-interface
  depends_on = [module.vnet]
}

module "ip" {
  source = "./modules/publicip"
  config = local.env.ip
}

module "attached-subnets" {
  source = "./modules/networking/attached-subnets"
  config = local.env.attach-nsg
  depends_on = [module.security-groups]

}



# module "subnet_nsg_associations" {
#   source = "../../../modules/networking/attach-subnets-security-groups"
#   config = local.env.attach-security-groups
#   depends_on = [module.security_groups]
# }