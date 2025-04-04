variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "db_username" {}
variable "db_password" {}
variable "db_name" {
  default = "medusa_db"
}
