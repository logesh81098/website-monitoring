variable "ami-id" {
  default = "ami-0d87d059b6138553e"
}

variable "instance-type" {
  default = "t3.medium"
}

variable "subnet-id" {
  default = {}
}

variable "security-group" {
  default = {}
}

variable "keypair-name" {
  default = {}
}

variable "instance-profile" {
  default = {}
}