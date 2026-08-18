output "identifier" {
  description = "RDS DB instance identifier used as the CloudWatch DBInstanceIdentifier dimension."
  value       = aws_db_instance.this.identifier
}
