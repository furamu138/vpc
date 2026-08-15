resource "aws_instance" "this" {
  count                       = var.instance_count
  ami                         = "ami-0b828c1c5ac3f13ee"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "${var.name_prefix}-ec2-${count.index + 1}"
  }
}
