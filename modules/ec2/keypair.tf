resource "aws_key_pair" "bastion_ssh" {
  key_name   = "${var.service_name}-keypair"
  public_key = file("~/.ssh/studying.pub")
}
