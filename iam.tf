# iam.tf - just reference existing role, don't create!
data "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole" # exact name from console
}
