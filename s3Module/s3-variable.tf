variable "env" {
  type    = string
  default = "PROD"
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "versioning" {
  type    = string
  default = "Enabled"
}

variable "create_vpc" {
  type    = bool
  default = true
}
