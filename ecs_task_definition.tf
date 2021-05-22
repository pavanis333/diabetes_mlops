resource "aws_ecs_task_definition" "deeplearning_task_definition" {
  depends_on = [aws_ecs_cluster.deeplearning_cluster]
  family = "deeplearning_task_definition"
  requires_compatibilities = ["FARGATE", "FARGATE_SPOT"]
  container_definitions = <<TASK_DEFINITION
  [
  {
    "cpu" : 128,
    "memory" : 256,
    "name": "${var.container_name}",
    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.image_name}:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 8080
      }
    ]
  }
  ]
  TASK_DEFINITION
}