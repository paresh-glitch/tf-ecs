variable "env" {
  description = "environment name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "030635937630"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "image_tag" {
  description = "Docker image tag injected by CI pipeline"
  type        = string
  default     = "latest"
}
