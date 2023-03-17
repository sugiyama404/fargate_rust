variable "apserver_sg_id" {}
variable "subnet_p1a_id" {}
variable "opmng_sg_id" {}
variable "aws_ami_app_id" {}

resource "aws_instance" "opmng_server" {
  ami                         = var.aws_ami_app_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_p1a_id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${var.apserver_sg_id}", "${var.opmng_sg_id}"]
  key_name                    = aws_key_pair.keypair.key_name
  user_data                   = file("./modules/ec2/mysql_reset")
}
