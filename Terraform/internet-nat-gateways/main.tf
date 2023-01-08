resource "aws_internet_gateway" "Igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.enviromentName} InternetGateway"
  }
}
