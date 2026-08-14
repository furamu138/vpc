resource "aws_db_instance" "this" {
  identifier = "udemy-terraform-rds"

  engine         = "mysql"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  username = var.username
  password = var.password

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.this.id]

  skip_final_snapshot = true
}

resource "aws_security_group" "this" {
  name   = "udemy-terraform-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "udemy-terraform-rds-sg"
  }
}
