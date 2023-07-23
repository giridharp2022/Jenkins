resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = var.r53recordset
  type    = "A"

  alias {
    name                   = aws_lb.jenkins.dns_name
    zone_id                = aws_lb.jenkins.zone_id
    evaluate_target_health = true
  }
}