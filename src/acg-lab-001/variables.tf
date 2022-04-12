variable "aws-east" {
  default = {
    # profile = "default"
    region = "us-east-1"
  }
}
variable "aws-west" {
  default = {
    # profile = "default"
    region = "us-west-2"
  }
}

variable "config-east" {
  default = {
    vpc_cidr = "10.0.0.0/16"
    subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  }
}
variable "config-west" {
  default = {
    vpc_cidr = "192.168.0.0/16"
    subnets  = ["192.168.1.0/24"]
  }
}