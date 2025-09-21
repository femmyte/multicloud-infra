variable "db_name" {
  default = "bridgetowork-db"
}

variable "collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  default =  "LicenseIncluded"
}
variable "max_size_gb" {
  default = 2
}
variable "sku_name" {
  default = "S0"
}
variable "enclave_type" {
  default = "VBS"
}
variable "administrator_login" {
  default = "4dm1n157r470r"
}
variable "db_server_name" {
  default = "bridgetowork-sqlserver"
}
variable "administrator_login_password" {
  default = "4-v3ry-53cr37-p455w0rd"
}

variable "db_version" {
  default = "12.0"
}

variable "client_id" {
  
}
variable "client_secret" {
  
}
variable "subscription_id" {
  
}
variable "tenant_id" {
  
}