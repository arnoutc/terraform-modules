variable "web_acl_name" {
  type = string
}

variable "web_acl_metrics" {
  type = string
}

variable "waf_rule_name" {
  type = string
}

variable "waf_rule_metrics" {
  type = string
}

variable "waf_rule_group_name" {
  type = string
}

variable "waf_rule_group_metrics" {
  type = string
}

variable "api_gateway_arn" {
  type = string
}

variable "lambda_version" {
 type = string
}

output "api_gateway_lambda_base_url" {
  value = "${aws_api_gateway_deployment.example.invoke_url}"
}