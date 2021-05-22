resource "aws_ecs_task_definition" "deeplearning_task_definition" {
  depends_on = [aws_ecs_cluster.deeplearning_cluster]
  family = "deeplearning_task_definition"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu = 1024
  memory = 2048
  container_definitions = <<TASK_DEFINITION
  [
  {
    "cpu" : 512,
    "memory" : 1024,
    "name": "${var.container_name}",
    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.image_name}:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
  ]
  TASK_DEFINITION
}
