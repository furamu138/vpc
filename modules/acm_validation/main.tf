data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "validation" {
  for_each = {
    for option in var.domain_validation_options :
    option.domain_name => {
      name   = option.resource_record_name
      type   = option.resource_record_type
      record = option.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60

  records = [each.value.record]

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = var.certificate_arn

  validation_record_fqdns = [
    for record in aws_route53_record.validation :
    record.fqdn
  ]
}