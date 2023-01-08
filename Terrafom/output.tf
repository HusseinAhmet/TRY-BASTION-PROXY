
output "jumpbox-pubIP" {
  value= module.jumpbox.jumpbox-pubIP
}
output "vpc-id" {
  value = module.vpc.vpc-id
}
output "priv-sub-1-id" {
  value = module.subnets.priv-sub-1-id
}
output "priv-sub-2-id" {
  value = module.subnets.priv-sub-2-id
}