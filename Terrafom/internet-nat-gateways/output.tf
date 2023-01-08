output "nat1-id" {
  value= aws_nat_gateway.Nat1.id
}
output "nat2-id" {
  value= aws_nat_gateway.Nat2.id
}
output "igw-id" {
  value= aws_internet_gateway.Igw.id
}