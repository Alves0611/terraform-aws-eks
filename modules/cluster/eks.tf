resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.service_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      var.public_subnet_1a,
      var.public_subnet_1b,
      var.public_subnet_1c
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_attachment
  ]

  tags = (
    {
      Name = "${var.service_name}-cluster"
    }
  )
}
