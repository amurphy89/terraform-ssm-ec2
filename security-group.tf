resource "aws_security_group" "public" {
  name   = "ash-m-public"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "private" {
  name   = "ash-m-private"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "private_allow_tcp_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public.id
  security_group_id        = aws_security_group.private.id
}

resource "aws_security_group_rule" "public_allow_tcp_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "allow_all_outbound_private" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "allow_all_outbound_public" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}