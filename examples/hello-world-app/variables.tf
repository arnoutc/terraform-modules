# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "postgres_config" {
  description = "The config for the Postgres DB"

  type = object({
    address = string
    port    = number
  })

  default = {
    address = "mock-postgres-address"
    port    = 12345
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World"
  type        = string
}

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "example"
}