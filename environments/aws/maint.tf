locals {
  VPC_NAME                  = "${var.project_name}-vpc"
  shared_aurora_db_username = "shop_edge_db_username"
}

module "network" {
  source          = "./modules/network"
  RESOURCE_PREFIX = var.project_name
  VPC_NAME        = local.VPC_NAME
  azs             = var.azs
}

module "secret_manager" {
  source          = "./modules/secret_manager"
  RESOURCE_PREFIX = var.project_name
  username        = local.shared_aurora_db_username
}



module "databases" {
  source                 = "./modules/database"
  RESOURCE_PREFIX        = var.project_name
  subnet_id_1            = module.network.subnet_id_1
  subnet_id_2            = module.network.subnet_id_2
  vpc_id                 = module.network.vpc_id
  aurora_database_name   = "ShopEdge"
  vpc_security_group_ids = module.network.aurora_security_group_id
  username               = local.shared_aurora_db_username
  password               = module.secret_manager.secret_password

  depends_on = [module.secret_manager]
  
}