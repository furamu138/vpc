# resource "aws_instance" "this" {
#   ami           = "ami-0b828c1c5ac3f13ee"
#   instance_type = "t2.micro"

#   subnet_id                   = var.subnet_id
#   vpc_security_group_ids      = [aws_security_group.this.id]
#   associate_public_ip_address = true

#   user_data = file("${path.module}/user_data.sh")

#   user_data_replace_on_change = true

#   tags = {
#     Name = "udemy-terraform-ec2"
#   }
# }

resource "aws_instance" "this" {
  count                       = var.instance_count
  ami                         = "ami-0b828c1c5ac3f13ee"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "udemy-terraform-ec2-${count.index + 1}"
  }
}

resource "random_id" "this" {
  byte_length = 8
}

# インデックス0番目のサブネットからVPC IDを取得するために、`data "aws_subnet" "this"`を使用しています。これにより、セキュリティグループの作成時に正しいVPC IDを指定できます。
data "aws_subnet" "this" {
  id = var.subnet_ids[0]
}

resource "aws_security_group" "this" {
  vpc_id = data.aws_subnet.this.vpc_id
  name   = "udemy-terraform-ec2-sg-${random_id.this.hex}"
}

resource "aws_security_group_rule" "ssh" {

  count = var.allow_ssh ? 1 : 0

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}