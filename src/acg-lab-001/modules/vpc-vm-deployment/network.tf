
/*
- creates a NACL with EVERYTHING allowed IN/OUT
- creates a RTB with a local route (for the VPC CIDR)
- creates a SG that allows [INBOUND * from SG] & [OUTBOUND * to 0.0.0.0/0]
*/
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "subnets" {
  for_each = toset(var.subnet_cidrs)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route" "internet-route" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_security_group_rule" "allow_inbound_ssh" {
  security_group_id = aws_vpc.vpc.default_security_group_id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "test-sg-rule"
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc" {
  value = aws_vpc.vpc
}