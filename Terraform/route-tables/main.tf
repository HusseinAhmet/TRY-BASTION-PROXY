resource "aws_route_table" "PublicRouteTable" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.IgwId
  }

  tags = {
    Name = "${var.enviromentName} PublicRouteTable "
  }
}
resource "aws_route_table_association" "PubRouteTableAssociate" {
  subnet_id      = var.pubSub1ID

  route_table_id = aws_route_table.PublicRouteTable.id
}
resource "aws_route_table_association" "PubRouteTableAssociate2" {
  subnet_id      = var.pubSub2ID

  route_table_id = aws_route_table.PublicRouteTable.id
}
