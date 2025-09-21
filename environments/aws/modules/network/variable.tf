variable "VPC_NAME" {
  description = "The name of the VPC to be created"
  type        = string
}
variable "RESOURCE_PREFIX" {

}
variable "azs" {
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(string)
  description = "A list of availability zones to use for the subnets"
}
