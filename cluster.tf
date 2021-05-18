variable "vpc_id" {
  default = "vpc-9400cce9"
}

variable "subnets" {
  type = list
  default = ["subnet-3ab97e0b", "subnet-60c7ad6e", "subnet-9951e1ff"]
}

resource "aws_security_group" "sg_lb" {
  name        = "sg_lb"
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "all"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "all"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "cluster_lb" {
  depends_on         = [aws_security_group.sg_lb]
  name               = "cluster-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_lb.id]
  subnets            = [var.subnets[0], var.subnets[1], var.subnets[2]]

}

resource "aws_ecs_cluster" "deeplearning_cluster" {
  depends_on = [aws_lb.cluster_lb]
  name = "deeplearning_cluster"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}

resource "aws_ecs_task_definition" "deeplearning_task_definition" {
  depends_on = [aws_ecs_cluster.deeplearning_cluster]
  family = "deeplearning_task_definition"
  requires_compatibilities = ["FARGATE", "FARGATE_SPOT"]
  container_definitions = file("service.json")
}

resource "aws_lb_target_group" "cluster_target_group" {
  name = "cluster-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "cluster_lb_listener"{
  load_balancer_arn = aws_lb_target_group.cluster_target_group.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.cluster_target_group.arn
    type = "forward"
  }
}

resource "aws_ecs_service" "deeplearning_service" {
        name            = "deeplearning_service"
  	cluster         = "${aws_ecs_cluster.deeplearning_cluster.id}"
  	task_definition = "${aws_ecs_task_definition.deeplearning_task_definition.family}"
  	desired_count   = 2

  	load_balancer {
    	target_group_arn  = "${aws_lb_target_group.cluster_target_group.arn}"
    	container_port    = 80
    	container_name    = "deeplearning"
	}
}
