provider "aws" {
  region  = "eu-west-3"
}

terraform {
  backend "s3" {
    bucket = "nodeapp-terraform-state-file"
    key    = "terraform1.tfstate"
    region = "eu-west-3"
  }
}
module "vpc" {
  source = "./vpc/"

  cidr = "10.0.0.0/16"
 enviromentName= " try-bastiioin "
}
module "subnets" {
  source = "./subnets/"

  vpc_id=module.vpc.vpc-id
enviromentName= " try-bastiioin "
  PubSub1 = "10.0.1.0/24"
  PubSub2 = "10.0.3.0/24"

  
}
module "internet-nat-gateways" {
    source = "./internet-nat-gateways/"

    vpc_id=module.vpc.vpc-id
enviromentName= " try-bastiioin "
    pubSub1ID=module.subnets.pub-sub-1-id
    pubSub2ID=module.subnets.pub-sub-2-id

}
module "route-tables" {
    source = "./route-tables/"

    vpc_id=module.vpc.vpc-id
enviromentName= " try-bastiioin "
    pubSub1ID=module.subnets.pub-sub-1-id
    pubSub2ID=module.subnets.pub-sub-2-id
IgwId=module.internet-nat-gateways.igw-id

}
module "ec2_servers" {
    source = "./ec2-servers/"

     vpc_id=module.vpc.vpc-id
     InstanceType="t2.micro"
     AmiID= "ami-03c476a1ca8e3ebdc"
     keyPair= "train-key"
enviromentName= " try-bastiioin "
  pubSub1ID=module.subnets.pub-sub-1-id
    pubSub2ID=module.subnets.pub-sub-2-id

}
module "jumpbox" {
    source = "./jumpbox/"
  
     vpc_id=module.vpc.vpc-id
     InstanceType="t2.micro"
     AmiID= "ami-03c476a1ca8e3ebdc"
     keyPair= "train-key"
  enviromentName= " try-bastiioin "
     pubSub1ID=module.subnets.pub-sub-1-id
}