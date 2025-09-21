
resource "azurerm_mssql_server" "example" {
  name                         = var.db_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = var.db_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "example" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.example.id
  collation    = var.collation
  license_type = var.license_type
  max_size_gb  = var.max_size_gb
  sku_name     = var.sku_name
  enclave_type = var.enclave_type

  tags = {
    name = var.db_name
  }

  # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
}