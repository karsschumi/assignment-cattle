##############
#ECS cluster #
##############

resource "aws_ecs_cluster" "cluster" {

    name = format("%s-%s",var.resource_name_prefix,"cluster")
    setting {
      name = "containerInsights"
      value = var.container_insights_value
    }
  
}

####################
#ECS container def #
####################

resource "aws_ecs_task_definition" "task_def" {
  
  family = format("%s-%s",var.resource_name_prefix,"task")
  container_definitions = jsonencode(var.container_definitions)
  task_role_arn = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.execution_role.arn
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  requires_compatibilities = ["FARGATE"]

}

######################
# ecs service #####
#####################

resource "aws_ecs_service" "service" {

  depends_on = [
    aws_lb.lb
  ]
   
   name = format("%s-%s",var.resource_name_prefix,"service")
   cluster = aws_ecs_cluster.cluster.id
   desired_count = var.desired_count
   health_check_grace_period_seconds = var.health_health_check_grace_period_seconds
   launch_type = "FARGATE"
   scheduling_strategy = "REPLICA"
   task_definition = aws_ecs_task_definition.task_def.arn
   force_new_deployment = var.force_new_deployment
  load_balancer {
    container_name = "app"
    container_port = var.container_port
    target_group_arn = aws_lb_target_group.tg.arn
  }
  network_configuration {
    security_groups = [aws_security_group.service_sg.id]
    subnets = var.ecs_service_subnets
  }

}

##################################
# ecs service security group #####
##################################

resource "aws_security_group" "service_sg" {

    name = format("%s-%s",var.resource_name_prefix,"serviceSg")
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

   ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }
}

########################
## ECS Autoscaling######
########################

resource "aws_appautoscaling_target" "ecs_asg_target" {
  
  min_capacity = var.ecs_asg_min_capacity
  max_capacity = var.ecs_asg_max_capacity

  resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "cpu" {
  
  name = format("%s-%s",var.resource_name_prefix,"asg-policy-cpu")
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_asg_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_asg_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_asg_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown = var.ecs_asg_scaling_in_cooldown
    scale_out_cooldown = var.ecs_asg_scaling_out_cooldown
    target_value = var.ecs_asg_cpu_percent
  }
}

resource "aws_appautoscaling_policy" "memory" {
  
  name = format("%s-%s",var.resource_name_prefix,"asg-policy-memory")
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_asg_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_asg_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_asg_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    scale_in_cooldown = var.ecs_asg_scaling_in_cooldown
    scale_out_cooldown = var.ecs_asg_scaling_out_cooldown
    target_value = var.ecs_asg_memory_percent
  }
}

resource "aws_appautoscaling_policy" "alb" {
  
  name = format("%s-%s",var.resource_name_prefix,"asg-alb-requests")
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_asg_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_asg_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_asg_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${aws_lb.lb.arn_suffix}/${aws_lb_target_group.tg.arn_suffix}"
    }
    scale_in_cooldown = var.ecs_asg_scaling_in_cooldown
    scale_out_cooldown = var.ecs_asg_scaling_out_cooldown
    target_value = var.ecs_asg_alb_requests
  }
}