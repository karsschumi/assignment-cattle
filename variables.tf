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
    description = "Identifier of the VPC in which to create the target group and security groups"
}
variable "tg_protocol"{
    description = "Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP. Required when target_type is instance, ip or alb. Does not apply when target_type is lambda."
}
variable "tg_port"{
    description = "Port on which targets receive traffic, unless overridden when registering a specific target."
}
variable "tg_target_type"{
    description = "ype of target that you must specify when registering targets with this target group."
}
variable "tg_deregistration_delay"{
    description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
}
variable "tg_healthy_threshold"{
    description = "Number of consecutive health checks successes required before considering an unhealthy target healthy."
}
variable "tg_healthcheck_interval"{
    description = "Approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds"
}
variable "tg_healthcheck_path"{
    description = "Destination for the health check request."
}
variable "tg_healthcheck_port"{
    description = "Port to use to connect with the target. Valid values are either ports 1-65535"
}
variable "tg_healthcheck_protocol"{
    description = "Protocol to use to connect with the target. Defaults to HTTP"
}
variable "tg_healthcheck_timeout"{
    description = "Amount of time, in seconds, during which no response means a failed health check."
}
variable "tg_healthcheck_unhealthy_threshold"{
    description = "Number of consecutive health check failures required before considering the target unhealthy."
}

####################
# Load Balancer sg #
####################

variable "alb_ingress_rules"{
    description = " A list of security group ignress rules to assign to the LB security group"
}

##################
# Load Balancer  #
##################

variable "alb_subnet_ids"{
    description = "A list of subnet IDs to attach to the LB"
}

##########################
# Load Balancer listener #
##########################

variable "aws_lb_listener_port"{
    description = "Port on which the load balancer is listening"
}

variable "aws_lb_listener_protocol"{
    description = "Protocol for connections from clients to the load balancer"
}

#######
# IAM #
#######
variable "execution_role_assume_policy_json"{
    description = "Policy that grants an entity permission to assume the execution role"
}
variable "execution_role_managed_policy"{
    description = "Managed policy of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
}
variable "task_role_assume_policy_json"{
    description = "Policy that grants an entity permission to assume the task role"
}
variable "task_role_managed_policy"{
    description = "Managed policy of IAM role that allows your Amazon ECS container task to make calls to other AWS services"
}

#######
# ECS #
#######
variable "container_insights_value" {
  description = "Value to be used to enable CloudWatch Container Insights for a cluster."
}
variable "container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document"
}
variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task."
}
variable "cpu" {
  description = "Number of cpu units used by the task"
}

variable "memory" {
  description = " Amount (in MiB) of memory used by the task"
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running. Defaults to 0."
}

variable "force_new_deployment" {
  description = " Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g., myimage:latest)"
}

variable "health_health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
}

variable "container_port" {
  description = "Port on the container to associate with the load balancer"
}

variable "ecs_service_subnets" {
  description = "Subnets associated with the task or service"
}

variable "ecs_asg_min_capacity" {
  description = "The min capacity of the scalable target."
}

variable "ecs_asg_max_capacity" {
  description = "The max capacity of the scalable target."
}

variable "ecs_asg_scaling_in_cooldown" {
  description = "The amount of time, in seconds, after a scale in activity completes before another scale in activity can start."
}

variable "ecs_asg_scaling_out_cooldown" {
 description = " The amount of time, in seconds, after a scale out activity completes before another scale out activity can start"  
}

variable "ecs_asg_cpu_percent" {
  description = "the target value for the CPU metric"
}

variable "ecs_asg_memory_percent" {
  description = "the target value for the memory metric"
}

variable "ecs_asg_alb_requests" {
  description = "the target value for the number of alb requests"
}