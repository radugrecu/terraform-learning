terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
}

#region providers
provider "aws" {
  region = var.aws-east.region
  # profile = var.aws-east.profile
  alias = "region-east"
}
provider "aws" {
  region = var.aws-west.region
  # profile = var.aws-west.profile
  alias = "region-west"
}
#endregion providers


module "vpc-vm-east" {
  source = "./modules/vpc-vm-deployment"
  providers = {
    aws = aws.region-east
  }
  vpc_cidr     = var.config-east.vpc_cidr
  subnet_cidrs = var.config-east.subnets
}
module "vpc-vm-west" {
  source = "./modules/vpc-vm-deployment"
  providers = {
    aws = aws.region-west
  }
  vpc_cidr     = var.config-west.vpc_cidr
  subnet_cidrs = var.config-west.subnets
}





output "vm-east" {
  value = module.vpc-vm-east.aws_ip
}
output "vm-west" {
  value = module.vpc-vm-west.aws_ip
}