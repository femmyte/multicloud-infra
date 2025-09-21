variable "RESOURCE_PREFIX" {
  description = "value of the project used for resource naming"
}

variable "vpc_id" {
  description = "The VPC ID where the RDS cluster will be deployed"
  type        = string

}

variable "subnet_id_1" {
  type        = string
  description = "The first subnet ID for the RDS subnet group"
}

variable "subnet_id_2" {
  type        = string
  description = "The second subnet ID for the RDS subnet group"
}

variable "aurora_database_name" {
  type        = string
  description = "value for the database name in the cluster"
}
variable "vpc_security_group_ids" {
  type        = string
  description = "List of VPC security group IDs to associate with the RDS cluster"
}
variable "username" {
  type        = string
  description = "value for the master username in the cluster"
}

variable "password" {
  type        = string
  description = "value for the master password in the cluster"
}

