output "dns_of_load_balancer" {
  value = aws_lb.cluster_lb.dns_name
}
