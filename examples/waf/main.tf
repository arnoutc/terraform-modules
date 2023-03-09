# Creating the IP Set to be defined in AWS WAF
resource "aws_wafv2_ip_set" "ipset" {
    name = "example"
    description = "Example IP set"
    scope = "REGIONAL"
    ip_address_version = "IPV4"
    addresses = ["192.0.7.0/24"] #allows only this IP and blocks everything else
    
    tags = {
      "Env" = "example"
    }
}

# Creating the Rule Group which will be applied on AWS Web ACL
resource "aws_wafv2_rule_group" "waf_rule_group" {
  name = var.waf_rule_group_name
  scope = "REGIONAL"
  capacity = 2

  rule {
    name = var.waf_rule_name
    priority = 50
    action {
      allow {}
    }
 
    statement {
      geo_match_statement {
        country_codes = ["US", "GB"]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = var.waf_rule_metrics
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.waf_rule_group_metrics
    sampled_requests_enabled   = false
  }
}

# Creating the Web ACL component in AWS WAF
resource "aws_wafv2_web_acl" "example" {
  name        = "rate-based-example"
  description = "Example of an API GATEWAY rate based statement."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = var.waf_rule_name
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "GB"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = var.web_acl_metrics
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Env = "example"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.web_acl_metrics
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "example" {
  //resource_arn = aws_api_gateway_rest_api.example.arn DOES NOT WORK IT SEEMS
  resource_arn = var.api_gateway_arn
  web_acl_arn  = aws_wafv2_web_acl.example.arn
}