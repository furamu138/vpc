output "application_resource_ids" {
  description = "Application resource identifiers available to future observability modules."
  value = {
    vpc_id                  = data.terraform_remote_state.application.outputs.vpc_id
    alb_arn_suffix          = data.terraform_remote_state.application.outputs.alb_arn_suffix
    target_group_arn_suffix = data.terraform_remote_state.application.outputs.target_group_arn_suffix
    ec2_instance_ids        = data.terraform_remote_state.application.outputs.ec2_instance_ids
    rds_identifier          = data.terraform_remote_state.application.outputs.rds_identifier
  }
}
