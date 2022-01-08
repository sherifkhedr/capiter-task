resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
 
  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
 
  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-rt"
  }
 
}