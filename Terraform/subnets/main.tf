data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "PubSub1" {
  vpc_id     =var.vpc_id
  cidr_block = var.PubSub1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.enviromentName} PublicSubnet1"
  }
}
resource "aws_subnet" "PubSub2" {
  vpc_id     =var.vpc_id
  cidr_block = var.PubSub2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.enviromentName} PublicSubnet2"
  }
}
