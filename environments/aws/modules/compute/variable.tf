variable "instance_type" {
  default     = ["t3.micro"]
  description = "values: t3.micro, t3.small, t3.medium"
}
# variable "key_name" {
#   description = "The name of the key pair to use for the instance"
#   type        = string
# }

variable "RESOURCE_PREFIX" {
  description = "value of the project used for resource naming"

}
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string

}

variable "vpc_id" {
  description = "The VPC ID where the instance will be deployed"
  type        = string

}
variable "subnet_id" {
  description = "The Subnet ID where the instance will be deployed"
  type        = string
}
variable "instance_security_group_id" {
  description = "List of VPC security group IDs to associate with the instance"
  type        = list(string)

}

variable "availability_zone" {
  description = "The availability zone where the instance will be deployed"
  type        = string

}