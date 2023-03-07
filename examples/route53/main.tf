resource "aws_route53_zone" "example" {
  name = "pacator.test.example.com"
}

resource "aws_route53_record" "example" {
  allow_overwrite = true
  name            = "pacator.test.example.com"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.example.zone_id

  records = [
    aws_route53_zone.example.name_servers[0],
    aws_route53_zone.example.name_servers[1],
    aws_route53_zone.example.name_servers[2],
    aws_route53_zone.example.name_servers[3],
  ]
}