resource "aws_ecs_cluster" "deeplearning_cluster" {
  depends_on = [aws_lb.cluster_lb]
  name = var.cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}


