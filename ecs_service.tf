resource "aws_ecs_service" "deeplearning_service" {
        depends_on      = [aws_lb_listener.cluster_lb_listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
        name            = var.service_name
  	cluster         = aws_ecs_cluster.deeplearning_cluster.id
  	task_definition = aws_ecs_task_definition.deeplearning_task_definition.arn
  	desired_count   = 1
	launch_type     = "FARGATE"

        network_configuration {
        security_groups  = [aws_security_group.sg_lb.id]
        subnets          = data.aws_subnet_ids.default.ids
        assign_public_ip = true
        }
	
  	load_balancer {
    	target_group_arn  = aws_lb_target_group.cluster_target_group.arn
    	container_port    = 80
    	container_name    = var.container_name
	}
}
