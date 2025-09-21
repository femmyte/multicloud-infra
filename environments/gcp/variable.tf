variable "project" {
  description = "The project ID"
  type        = string
  default = "femmyte"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "bridgetowork-dev"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default = "bridgetowork-public-subnet"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.2.0.0/16"
}

variable "subnet_region" {
  description = "The region for the subnet"
  type        = string
  default = "europe-west"
}

variable "region" {
  description = "The region for the subnet"
  type        = string
  default = "europe-west1"
}

variable "db_machine_type" {
  default = "db-f1-micro"
  description = "database machine type"
}
