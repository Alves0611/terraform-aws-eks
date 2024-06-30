data "tls_certificate" "gh_ations_tls_certificate" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "gh_actions_oidc" {
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = data.tls_certificate.gh_ations_tls_certificate.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.gh_ations_tls_certificate.url
  tags = (
    {
      Name = "${var.service_name}-gh-actions-oidc"
    }
  )
}


resource "aws_iam_role" "gh_actions_oidc_role" {
  name = "${var.service_name}-gh-actions-oidc-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.gh_actions_oidc.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity"
            }
        }
    ]
}
EOF

  tags = (
    {
      Name = "${var.service_name}-aws-load-balancer-controller"
    }
  )
}
