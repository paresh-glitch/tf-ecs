resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "capacity" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
