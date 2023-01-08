resource "aws_instance" "bastionServer" {  
  ami = var.AmiID
  instance_type = var.InstanceType
  subnet_id = var.pubSub1ID
  vpc_security_group_ids = [ aws_security_group.bastionSecGrp.id]
  key_name = var.keyPair

  tags = {
    Name = "${var.enviromentName} - Jumpbox"
  }
#      provisioner "local-exec" {
#    command = "echo ${self.public_ip} >> inventory.txt"
#  }
 provisioner "file" {
    source      = "/home/ubuntu/train-key.pem"
    destination = "/home/ubuntu/train-key.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("/home/ubuntu/train-key.pem")}"
      host        = "${self.public_dns}"
    }
  }
}

resource "aws_security_group" "bastionSecGrp" {

  vpc_id      = var.vpc_id

  ingress {
   
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
   ingress {
   
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
}
