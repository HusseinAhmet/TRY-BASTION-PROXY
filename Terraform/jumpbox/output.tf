output "jumpbox-pubIP" {
  value= aws_instance.bastionServer.public_ip
}