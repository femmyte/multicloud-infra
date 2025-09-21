locals {
  project = "femmyte"
}
# Enable required Google APIs


module "network" {
  source = "./module/network"
  project = local.project

}

module "compute" {
  source = "./module/compute"
  network_attachment = module.network.network_attachment
  project = local.project
}

module "database" {
  source = "./module/database"
  db_machine_type = var.db_machine_type
  vpc_name = module.network.network_id
  db_name = "${var.project}-db"
  region = var.region
  project = local.project
  network_self_link = module.network.network_self_link

depends_on = [ module.network ]
}
