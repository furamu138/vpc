moved {
  from = module.alb.random_id.this
  to   = module.security_groups.random_id.alb
}

moved {
  from = module.alb.aws_security_group.this
  to   = module.security_groups.aws_security_group.alb
}

moved {
  from = module.alb.aws_security_group_rule.http
  to   = module.security_groups.aws_security_group_rule.alb_http_ingress
}

moved {
  from = module.alb.aws_security_group_rule.https
  to   = module.security_groups.aws_security_group_rule.alb_https_ingress
}

moved {
  from = module.alb.aws_security_group_rule.egress
  to   = module.security_groups.aws_security_group_rule.alb_egress
}

moved {
  from = module.alb.aws_security_group_rule.alb_to_enter_instance
  to   = module.security_groups.aws_security_group_rule.ec2_http_from_alb
}

moved {
  from = module.ec2.random_id.this
  to   = module.security_groups.random_id.ec2
}

moved {
  from = module.ec2.aws_security_group.this
  to   = module.security_groups.aws_security_group.ec2
}

moved {
  from = module.ec2.aws_security_group_rule.ssh
  to   = module.security_groups.aws_security_group_rule.ec2_ssh_ingress
}

moved {
  from = module.ec2.aws_security_group_rule.egress
  to   = module.security_groups.aws_security_group_rule.ec2_egress
}

moved {
  from = module.rds.aws_security_group.this
  to   = module.security_groups.aws_security_group.rds
}
