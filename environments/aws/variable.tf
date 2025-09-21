variable "project_name" {
  default = "bridgetowork"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "values: t2.micro, t2.small, t2.medium"
}
variable "azs" {
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(string)
  description = "A list of availability zones to use for the subnets"

}