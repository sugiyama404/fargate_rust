# SecurityGroupRules for ALB
resource "aws_security_group_rule" "alb_in_http" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_in_https" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# SecurityGroupRules for Fargate api
resource "aws_security_group_rule" "apserver_in_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_db" {
  type              = "egress"
  from_port         = 3600
  to_port           = 3600
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_http" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

resource "aws_security_group_rule" "apserver_out_https" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apserver_sg.id
}

# SecurityGroupRules for Fargate web
resource "aws_security_group_rule" "webserver_in_alb" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_http" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

resource "aws_security_group_rule" "webserver_out_https" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver_sg.id
}

# SecurityGroupRules for opmng
resource "aws_security_group_rule" "opmng_in_ssh" {
  security_group_id = aws_security_group.opmng_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "opmng_out_http" {
  security_group_id = aws_security_group.opmng_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "opmng_out_https" {
  security_group_id = aws_security_group.opmng_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

# SecurityGroupRules for db
resource "aws_security_group_rule" "rds_in_api" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.apserver_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "rds_in_opmng" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.opmng_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}
