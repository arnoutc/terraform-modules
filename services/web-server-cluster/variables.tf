# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_remote_state_bucket" {
  description   = "The name of the S3 bucket used for the database's remote state storage"
  type          = string
}

variable "db_remote_state_key" {
  description   = "The name of the key in the S3 bucket used for the database's remote state storage"
  type          = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 10
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "cluster_name" {
  description = "The name to use to namespace all the resources in the cluster"
  type        = string
}

variable "region" {
    description = "Region used for state file"
    type = string
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type = bool
}

variable "ami" {
  description = "The AMI to run in the cluster"
  default = "ami-0d09654d0a20d3ae2"
  type = string
}

variable "server_text" {
  description = "The text the web server should return"
  default = "Hello, Zero Downtime Release"
  type = string
}