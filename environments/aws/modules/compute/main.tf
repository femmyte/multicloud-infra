resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  # key_name      = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.instance_security_group_id
  availability_zone      = var.availability_zone
  tags = {
    Name        = "${var.RESOURCE_PREFIX}-ec2-instance"
    Bridge2Work = "true"
  }
}