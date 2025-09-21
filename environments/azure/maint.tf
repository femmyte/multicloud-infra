data "azurerm_resource_group" "rg" {
  name = "kml_rg_main-da471872899144bb"
}
locals {
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
}
# resource "azurerm_resource_group" "resource_group" {
#   name     = "example-resources"
#   location = "West Europe"
# }




module "network" {
  source = "./module/network"
  # resource_group_name = azurerm_resource_group.resource_group.managed_by
  # resource_group_location = azurerm_resource_group.resource_group.location
  resource_group_location = local.location
  resource_group_name = local.resource_group_name
}

module "compute" {
  source = "./module/compute"
   resource_group_location = local.location
  resource_group_name = local.resource_group_name
  # resource_group_name = azurerm_resource_group.resource_group.managed_by
  # resource_group_location = azurerm_resource_group.resource_group.location
  network_interface_id = module.network.network_interface_id
}

module "database" {
  source = "./module/database"
  # resource_group_name = azurerm_resource_group.resource_group.managed_by
  # resource_group_location = azurerm_resource_group.resource_group.location
   resource_group_location = local.location
  resource_group_name = local.resource_group_name
  db_name = var.db_name
  administrator_login = var.administrator_login
  enclave_type = var.enclave_type
  db_version = var.db_version
  sku_name = var.sku_name
  db_server_name = var.db_server_name
  collation = var.collation
  max_size_gb = var.max_size_gb
  administrator_login_password = var.administrator_login_password
  license_type = var.license_type
}