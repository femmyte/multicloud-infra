output "vpc_id" {
  value = aws_vpc.main.id
}
output "subnet_id_1" {
  value = aws_subnet.subnet_1.id
}
output "subnet_id_2" {
  value = aws_subnet.subnet_2.id
}

output "subnet_group_id" {
  value = aws_db_subnet_group.mydb_subnet_group.id
}

output "aurora_security_group_id" {
  value = aws_security_group.db_cluster_sg.id
}

output "instance_security_group_id" {
  value = aws_security_group.instance.id

}