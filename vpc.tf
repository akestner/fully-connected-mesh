resource "aws_vpc" "fully-connected" {
  tags = {
    Name = "fully-connected"
  }
  cidr_block = "10.0.0.0/16"

}
