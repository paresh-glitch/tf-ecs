resource "aws_ecs_task_definition" "my_td" {
  family = "${var.env}_td"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = data.aws_iam_role.ecs_execution_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "mongo"
      image     = local.mongo_url
      cpu       = 256
      memory    = 1536
      essential = true
      portMappings = [
        {
          containerPort = 27017
          hostPort      = 27017
          protocol      = "tcp"
        }
      ]

      healthCheck = {

        command     = ["CMD", "mongosh", "--eval", "db.adminCommand('ping')"]
        interval    = 30
        retries     = 5
        startPeriod = 30
        timeout     = 5

      }
    },
    {
      name      = "backend"
      image     = local.backend_url
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "MONGO_URI"
          value = "mongodb://localhost:27017/tododb"
        },
        {
          name  = "PORT"
          value = "5000"
        }
      ]

      dependsOn = [
        {
          containerName = "mongo"
          condition     = "HEALTHY"
        }
      ]

    },
    {
      name      = "frontend"
      image     = local.frontend_url
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      dependsOn = [
        {
          containerName = "backend"
          condition     = "START"
        }
      ]
    }
  ])

}
