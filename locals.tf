locals {
  ecr_base     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  frontend_url = "${local.ecr_base}/${var.env}-frontend:${var.image_tag}"
  backend_url  = "${local.ecr_base}/${var.env}-backend:${var.image_tag}"
  mongo_url    = "mongo:6"
}
