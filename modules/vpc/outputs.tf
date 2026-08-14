output "public_subnet_ids" {
  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}

output "vpc_id" {
  value = aws_vpc.this.id
}