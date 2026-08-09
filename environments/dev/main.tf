module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source    = "../../modules/ec2"
  allow_ssh = true
  subnet_id = module.vpc.public_subnet_ids[0]
}

module "alb" {
  source                     = "../../modules/alb"
  subnet_ids                 = module.vpc.public_subnet_ids
  instance_id                = module.ec2.instance_id
  instance_security_group_id = module.ec2.instance_security_group_id

  certificate_arn = module.acm.certificate_arn
}

module "route53" {
  source       = "../../modules/route53"
  domain_name  = "ruriha-rura.com"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "acm" {
  source      = "../../modules/acm"
  domain_name = "ruriha-rura.com"
}

module "acm_validation" {
  source                    = "../../modules/acm_validation"
  domain_name               = "ruriha-rura.com"
  certificate_arn           = module.acm.certificate_arn
  domain_validation_options = module.acm.domain_validation_options
}