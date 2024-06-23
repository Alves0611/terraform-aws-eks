resource "aws_ecr_repository" "this" {
  name         = "${var.service_name}-ecr"
  force_delete = true
}
