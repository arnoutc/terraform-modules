output "aws_waf_rule_arn" {
  value = aws_wafv2_rule_group.waf_rule_group.arn
}

output "aws_waf_rule_id" {
    value = aws_wafv2_web_acl.example.id
}

output "aws_waf_web_acl_arn" {
  value = aws_wafv2_web_acl.example.arn
}

output "aws_waf_web_acl_id" {
  value = aws_wafv2_web_acl.example.id
}

output "aws_waf_rule_group_arn" {
  value = aws_wafv2_rule_group.waf_rule_group.arn
}

output "aws_waf_rule_group_id" {
    value = aws_wafv2_rule_group.waf_rule_group.id
}