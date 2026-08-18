output "url" {
  value = "https://${module.route53.domain_name}"
}

output "vpc_id" {
  description = "VPC ID consumed by the observability configuration."
  value       = module.vpc.vpc_id
}

output "alb_arn_suffix" {
  description = "ALB ARN suffix consumed by CloudWatch alarms."
  value       = module.alb.alb_arn_suffix
}

output "target_group_arn_suffix" {
  description = "Target group ARN suffix consumed by CloudWatch alarms."
  value       = module.alb.target_group_arn_suffix
}

output "ec2_instance_ids" {
  description = "EC2 instance IDs consumed by CloudWatch alarms."
  value       = module.ec2.instance_ids
}

output "rds_identifier" {
  description = "RDS identifier consumed by CloudWatch alarms."
  value       = module.rds.identifier
}
