resource "aws_iam_policy" "eks_controller_policy" {
  name   = "${var.service_name}-aws-load-balancer-controller"
  policy = file("${path.module}/iam_policy.json")
}

resource "aws_iam_policy" "external_dns_policy" {
  name   = "${var.service_name}-external-dns"
  policy = file("${path.module}/iam_externaldns_policy.json")
}
