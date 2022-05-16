#########
# Target group #
########

resource "aws_lb_target_group" "tg" {

    name = format("%s-%s",var.resource_name_prefix,"tg")
    vpc_id = var.vpc_id
    protocol = var.tg_protocol
    port = var.tg_port 
    target_type = var.tg_target_type 
    deregistration_delay = var.tg_deregistration_delay

    health_check {
      enabled = true
      healthy_threshold = var.tg_healthy_threshold
      interval = var.tg_healthcheck_interval
      path = var.tg_healthcheck_path
      port = var.tg_healthcheck_port
      protocol = var.tg_healthcheck_protocol
      timeout = var.tg_healthcheck_timeout
      unhealthy_threshold = var.tg_healthcheck_unhealthy_threshold

    }
}


##################################
# ecs alb security group #####
##################################

resource "aws_security_group" "alb_sg" {

    name = format("%s-%s",var.resource_name_prefix,"albSg")
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    dynamic "ingress" {
        for_each = var.alb_ingress_rules
        content {
            protocol = lookup(ingress.value,"protocol",null)
            from_port = lookup(ingress.value,"from_port",null)
            to_port = lookup(ingress.value,"to_port",null)
            cidr_blocks = lookup(ingress.value,"cidr_blocks",null)
            security_groups = lookup(ingress.value,"security_groups",null)
        }

    }
}

################
# ecs  alb  ####
################

resource "aws_lb" "lb" {

 name =  format("%s-%s",var.resource_name_prefix,"alb")
 internal = false
 load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnet_ids

  enable_deletion_protection = true

}

#####################
# ecs alb listener  #
#####################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.aws_lb_listener_port
  protocol          = var.aws_lb_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}