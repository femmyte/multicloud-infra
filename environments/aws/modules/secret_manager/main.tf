resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}:,.<>?" # excludes '/', '@', '"', and space
}

resource "aws_secretsmanager_secret" "shared_db_secret" {
  name        = "${var.RESOURCE_PREFIX}-shared-db-secret-manager"
  description = "Database credentials for Aurora"
}

resource "aws_secretsmanager_secret_version" "shared_db_secret_version" {
  secret_id = aws_secretsmanager_secret.shared_db_secret.id
  secret_string = jsonencode({
    username = var.username,
    password = random_password.db_password.result
  })
}