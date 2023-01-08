resource "aws_instance" "server1" {
  ami               = var.AmiID
  instance_type          = var.InstanceType
  vpc_security_group_ids = [aws_security_group.ec2SecurityGrp.id]
  key_name               = var.keyPair
  subnet_id              = var.pubSub1ID
  tags = {
    "Name" = "${var.enviromentName}- Server1"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /home/ubuntu/jenkins_home/workspace/TRY-BASTION-PROXY/inventory.txt"
  }
}
resource "aws_instance" "server2" {
  ami               = var.AmiID
  instance_type          = var.InstanceType
  vpc_security_group_ids = [aws_security_group.ec2SecurityGrp.id]
  key_name               = var.keyPair
  subnet_id              = var.pubSub2ID
  tags = {
    "Name" = "${var.enviromentName}- Server2"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> /home/ubuntu/jenkins_home/workspace/TRY-BASTION-PROXY/inventory.txt"
  }
}
resource "aws_security_group" "ec2SecurityGrp" {

  vpc_id = var.vpc_id

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.enviromentName} -ec2-sec-grp"
  }
}
