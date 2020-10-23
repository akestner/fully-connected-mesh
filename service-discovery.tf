resource "aws_service_discovery_private_dns_namespace" "fully-connected" {
  name = "fully-connected.local"
  vpc = aws_vpc.fully-connected.id
  depends_on = [
    aws_vpc.fully-connected
  ]
}
