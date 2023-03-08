# terraform-modules

## Summary

This project is a template for a Terraform project based upon the structure described in 
[Terraform Up And Running](https://blog.gruntwork.io/terraform-up-running-3rd-edition-early-release-is-now-available-4efd0eb2ce0a).

The idea of a [modules](https://github.com/arnoutc/terraform-modules) repo is explained in Terraform Up And Running as:

- use small modules focusing on one concern only.
- use composable modules that can be reused in different environments.
- use reusable modules by creating version tags to use in a separate environments [live](https://github.com/arnoutc/terraform-live) repo that can then use different versions of the modules in the various dev, stage, prod environments.
- use unit and integration tests 

## Development

The examples folder contains hard coded boilerplate code for various AWS services, such as S3, Lambda, API Gateway, SQS, VPC
