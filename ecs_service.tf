resource "aws_ecs_service" "deeplearning_service" {
    name            = var.service_name
  	cluster         = aws_ecs_cluster.deeplearning_cluster.id
  	task_definition = aws_ecs_task_definition.deeplearning_task_definition.family
  	desired_count   = 2

  	load_balancer {
    	target_group_arn  = aws_lb_target_group.cluster_target_group.arn
    	container_port    = 80
    	container_name    = var.container_name
	}
}
