resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "medusa-backend"
      image     = aws_ecr_repository.medusa_repo.repository_url
      essential = true
      environment = [
        { name = "DATABASE_URL", value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.medusa_db.endpoint}/${var.db_name}" }
      ]
      portMappings = [{ containerPort = 9000 }]
    }
  ])
}

resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster        = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.medusa_sg.id]
    assign_public_ip = true
  }
}
