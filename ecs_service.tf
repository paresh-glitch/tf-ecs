resource "aws_ecs_service" "service" {
  name            = "${var.env}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.my_td.arn
  desired_count   = 1
  launch_type     = "FARGATE" # ✅ missing!

  network_configuration { # ✅ missing!
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "frontend"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.front_end] # ✅ missing!
}
