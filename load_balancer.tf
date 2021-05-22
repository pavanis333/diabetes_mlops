resource "aws_lb" "cluster_lb" {
  depends_on         = [aws_security_group.sg_lb]
  name               = "cluster-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_lb.id]
  subnets            = data.aws_subnet_ids.default.ids
}

resource "aws_lb_target_group" "cluster_target_group" {
  name = "cluster-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb_listener" "cluster_lb_listener"{
  load_balancer_arn = aws_lb.cluster_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.cluster_target_group.arn
    type = "forward"
  }
}