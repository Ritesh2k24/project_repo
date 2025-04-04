resource "aws_db_instance" "medusa_db" {
  allocated_storage    = 20
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  username           = var.db_username
  password           = var.db_password
  skip_final_snapshot = true
}
