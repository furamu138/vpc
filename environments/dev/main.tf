locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix = local.name_prefix
  # nat_gateway_count = 3
}

module "security_groups" {
  source = "../../modules/security_groups"

  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source            = "../../modules/ec2"
  name_prefix       = local.name_prefix
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.ec2_security_group_id
  instance_count    = 2
}

module "alb" {
  source = "../../modules/alb"

  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id

  subnet_ids        = module.vpc.public_subnet_ids
  instance_ids      = module.ec2.instance_ids
  security_group_id = module.security_groups.alb_security_group_id
  certificate_arn   = module.acm_validation.certificate_arn
}

module "rds" {
  source = "../../modules/rds"

  name_prefix       = local.name_prefix
  db_subnet_ids     = module.vpc.db_subnet_ids
  security_group_id = module.security_groups.rds_security_group_id

  username = "admin"
  password = var.db_password
}

module "route53" {
  source       = "../../modules/route53"
  domain_name  = "ruriha-rura.com"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "acm" {
  source      = "../../modules/acm"
  name_prefix = local.name_prefix
  domain_name = "ruriha-rura.com"
}

module "acm_validation" {
  source                    = "../../modules/acm_validation"
  domain_name               = "ruriha-rura.com"
  certificate_arn           = module.acm.certificate_arn
  domain_validation_options = module.acm.domain_validation_options
}
