data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.linux.id

  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id = aws_subnet.private[0].id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = false

  tags = {
      Name = "ash-m-ssm-box"
  }
}