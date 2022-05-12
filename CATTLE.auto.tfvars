region = "us-east-1"
access_key = ""
secret_key = ""
resource_name_prefix = "source"
vpc_id = "vpc-065c378168e28a6e9"
tg_protocol = "HTTP"
tg_port = 80
tg_target_type = "ip"
tg_deregistration_delay = 900
tg_healthy_threshold = 3
tg_healthcheck_path = "/"
tg_healthcheck_port = 8000
tg_healthcheck_protocol = "HTTP" 
tg_healthcheck_timeout = 10
tg_healthcheck_threshold = 5
tg_healthcheck_interval = 120
alb_ingress_rules = [
    {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
]
alb_subnet_ids = ["subnet-055f6c3e15c02d0b4","subnet-05f2f907943259b42"]
aws_lb_listener_port = 80
aws_lb_listener_protocol = "HTTP"
execution_role_managed_policy = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy","arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"] 
execution_role_assume_policy_json  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
task_role_assume_policy_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
task_role_managed_policy =  ["arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]

container_insights_value = "enabled"

container_definitions = [
    {
      name      = "db"
      image     = "postgres:13.6"
      essential = true
      portMappings = [
        {
          containerPort = 5432
          hostPort      = 5432
          protocol = "tcp"
        }
      ]
    environment = [
      {
          "name":"POSTGRES_PASSWORD"
          "value":"admin"
      },
      {
          "name":"POSTGRES_DB"
          "value":"todoozie_db"
      }
    ]
        logConfiguration = {
                logDriver = "awslogs",
                options = {
                    awslogs-group = "source-log-group",
                    awslogs-region = "us-east-1",
                    awslogs-stream-prefix = "db-container-logs"
                }
    }
    HealthCheck = {
        command = ["CMD-SHELL", "pg_isready" ],
        interval = 20
        timeout= 5
        retries= 5
    }
    },


    {
      name      = "app"
      image     = "904204322916.dkr.ecr.us-east-1.amazonaws.com/source-repo:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol = "tcp"
        }
      ]
    environment = [
      {
          "name":"SECRET_KEY"
          "value":"77b070105b32e1b78c3b16374702a634ca1349e966e2c9e4cede09154a0e048f"
      },
      {
          "name":"DB_PASSWORD"
          "value":"admin"
      },
      {
          "name":"DB_HOST"
          "value":"db"
      }
    ]
    logConfiguration = {
                logDriver = "awslogs",
                options = {
                    awslogs-group = "source-log-group",
                    awslogs-region = "us-east-1",
                    awslogs-stream-prefix = "app-container-logs"
                }
    }
     dependsOn = [
    {
       containerName: "db",
        condition: "HEALTHY"
  }
 ]
    }
  ]
network_mode = "awsvpc"

cpu = 2048

memory = 4096

desired_count = 1

health_health_check_grace_period_seconds = 300

container_port = 8000

ecs_service_subnets = ["subnet-047a4e0f9964391da","subnet-034a5b7ae165c306d"]