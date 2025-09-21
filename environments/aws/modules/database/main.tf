resource "aws_db_subnet_group" "shared_cluster_subnet_group" {
  name = "${var.RESOURCE_PREFIX}-cluster-subnet-group"
  subnet_ids = [
    var.subnet_id_1,
    var.subnet_id_2
  ]

  tags = {
    Name = "AuroraSubnetGroup"
  }
}


resource "aws_rds_cluster" "shared_db_cluster" {
  cluster_identifier           = "${var.RESOURCE_PREFIX}-shared-db-cluster"
  engine                       = "aurora-postgresql"
  engine_mode                  = "provisioned"
  engine_version               = "16.6"
  database_name                = var.aurora_database_name
  master_username              = var.username
  master_password              = var.password
  storage_encrypted            = true
  db_subnet_group_name         = aws_db_subnet_group.shared_cluster_subnet_group.name
  vpc_security_group_ids       = [var.vpc_security_group_ids]
  skip_final_snapshot          = true
  deletion_protection          = false
  backup_retention_period      = 7
  apply_immediately            = true
  preferred_maintenance_window = null
  enable_http_endpoint         = true

  serverlessv2_scaling_configuration {
    max_capacity = 4.0
    min_capacity = 0.5
    # seconds_until_auto_pause = 3600
  }
  enabled_cloudwatch_logs_exports = ["postgresql"]
  tags = {
    Name = "${var.RESOURCE_PREFIX}-db-cluster"
  }
}

resource "aws_rds_cluster_instance" "shared_db_cluster_instance" {
  count               = 2
  cluster_identifier  = aws_rds_cluster.shared_db_cluster.id
  identifier          = "${var.RESOURCE_PREFIX}-instance-${count.index}"
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.shared_db_cluster.engine
  engine_version      = aws_rds_cluster.shared_db_cluster.engine_version
  # monitoring_interval = 60 # Collects enhanced monitoring metrics every 60s
  # monitoring_role_arn = var.rds_monitoring_arn
}