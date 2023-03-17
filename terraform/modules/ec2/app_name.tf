variable "app_name" {}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.app_name}-keypair"
  public_key = file("./modules/ec2/rsa.pub")
}
