variable "http_ports" {}
variable "https_ports" {}
variable "ssh_ports" {}
variable "web_ports" {}
variable "api_ports" {}
variable "db_ports" {}

# SecurityGroupRules for ALB
resource "aws_security_group_rule" "alb_in_http" {
  type              = "ingress"
  from_port         = http_ports.internal
  to_port           = http_ports.external
  protocol          = http_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

#resource "aws_security_group_rule" "alb_in_https" {
#  type              = "ingress"
#  protocol          = "tcp"
#  from_port         = 443
#  to_port           = 443
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.alb_sg.id
#}

# SecurityGroupRules for Fargate api
resource "aws_security_group_rule" "apserver_in_alb" {
  type              = "ingress"
  from_port         = api_ports.internal
  to_port           = api_ports.external
  protocol          = api_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_db" {
  type              = "egress"
  from_port         = db_ports.internal
  to_port           = db_ports.external
  protocol          = db_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_http" {
  type              = "egress"
  from_port         = http_ports.internal
  to_port           = http_ports.external
  protocol          = http_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_https" {
  type              = "egress"
  from_port         = https_ports.internal
  to_port           = https_ports.external
  protocol          = https_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

# SecurityGroupRules for Fargate web
resource "aws_security_group_rule" "webserver_in_alb" {
  type              = "ingress"
  from_port         = web_ports.internal
  to_port           = web_ports.external
  protocol          = web_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_http" {
  type              = "egress"
  from_port         = http_ports.internal
  to_port           = http_ports.external
  protocol          = http_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_https" {
  type              = "egress"
  from_port         = https_ports.internal
  to_port           = https_ports.external
  protocol          = https_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

# SecurityGroupRules for opmng
resource "aws_security_group_rule" "opmng_in_ssh" {
  security_group_id = aws_security_group.opmng_sg.id
  type              = "ingress"
  from_port         = ssh_ports.internal
  to_port           = ssh_ports.external
  protocol          = ssh_ports.protocol
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "opmng_out_full" {
  security_group_id = aws_security_group.opmng_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# SecurityGroupRules for db
resource "aws_security_group_rule" "rds_in_api" {
  type                     = "ingress"
  from_port                = db_ports.internal
  to_port                  = db_ports.external
  protocol                 = db_ports.protocol
  source_security_group_id = aws_security_group.apserver_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "rds_in_opmng" {
  type                     = "ingress"
  from_port                = db_ports.internal
  to_port                  = db_ports.external
  protocol                 = db_ports.protocol
  source_security_group_id = aws_security_group.opmng_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}
