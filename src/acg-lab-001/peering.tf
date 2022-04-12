
resource "aws_vpc_peering_connection" "peer" {
  provider = aws.region-east
  vpc_id   = module.vpc-vm-east.vpc_id

  peer_vpc_id = module.vpc-vm-west.vpc_id
  peer_region = var.aws-west.region
}
resource "aws_vpc_peering_connection_accepter" "peer-accept" {
  provider                  = aws.region-west
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
}
resource "aws_vpc_peering_connection_options" "vpc-peering-opts-requester" {
  provider                  = aws.region-east
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  # options can't be set until the peering has been accepted
  # therefore we need to create explicit dependency on accepter
  depends_on = [aws_vpc_peering_connection_accepter.peer-accept]
}
resource "aws_vpc_peering_connection_options" "vpc-peering-opts-approver" {
  provider                  = aws.region-west
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer-accept.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "rt-east-to-west" {
  provider = aws.region-east
  route_table_id            = module.vpc-vm-east.vpc.main_route_table_id
  destination_cidr_block    = module.vpc-vm-west.vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
resource "aws_route" "rt-west-to-east" {
  provider = aws.region-west
  route_table_id            = module.vpc-vm-west.vpc.main_route_table_id
  destination_cidr_block    = module.vpc-vm-east.vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}