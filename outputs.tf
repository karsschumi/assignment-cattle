########################
# IAM Role outputs######
########################
output "task_execution_role_arn" {
  value = aws_iam_role.execution_role.arn
}

output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}

#############################
# Load balancer outputs######
#############################
output "load_balancer_arn" {
  value = aws_lb.lb.arn
}

output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}

output "load_balancer_target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "load_balancer_lister_arn" {
  value = aws_lb_listener.front_end.arn
}

output "load_balancer_security_group_id" {
  value = aws_security_group.alb_sg.id
}

###################
# ecs outputs######
###################
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "ecs_service" {
  value = aws_ecs_service.service.id
}

output "ecs_service_security_group_id" {
  value = aws_security_group.service_sg.id
}