####################
# Common variables #
####################
variable "resource_name_prefix"{
    description = "Name prefix to be used for all the resources"
}


####################
# Load Balancer Tg #
####################
variable "vpc_id"{
    description = "VPC id"
}
variable "tg_protocol"{
    description = "protocol for LB"
}
variable "tg_port"{
    description = "VPC id"
}
variable "tg_target_type"{
    description = "VPC id"
}
variable "tg_deregistration_delay"{
    description = "VPC id"
}
variable "tg_healthy_threshold"{
    description = "VPC id"
}
variable "tg_healthcheck_interval"{
    description = "VPC id"
}
variable "tg_healthcheck_path"{
    description = "VPC id"
}
variable "tg_healthcheck_port"{
    description = "VPC id"
}
variable "tg_healthcheck_protocol"{
    description = "VPC id"
}
variable "tg_healthcheck_timeout"{
    description = "VPC id"
}
variable "tg_healthcheck_threshold"{
    description = "VPC id"
}

####################
# Load Balancer sg #
####################

variable "alb_ingress_rules"{
    description = "VPC id"
}

##################
# Load Balancer  #
##################

variable "alb_subnet_ids"{
    description = "VPC id"
}

##########################
# Load Balancer listener #
##########################

variable "aws_lb_listener_port"{
    description = "VPC id"
}

variable "aws_lb_listener_protocol"{
    description = "VPC id"
}

#######
# IAM #
#######
variable "execution_role_assume_policy_json"{
    description = "VPC id"
}
variable "execution_role_managed_policy"{
    description = "VPC id"
}
variable "task_role_assume_policy_json"{
    description = "VPC id"
}
variable "task_role_managed_policy"{
    description = "VPC id"
}

#######
# ECS #
#######
variable "container_insights_value" {
  
}
variable "container_definitions" {
  
}
variable "network_mode" {
  
}
variable "cpu" {
  
}

variable "memory" {
  
}

variable "desired_count" {
  
}

variable "health_health_check_grace_period_seconds" {
  
}

variable "container_port" {
  
}

variable "ecs_service_subnets" {
  
}
