provider "aws" {
  
    region = "eu-west-2"

}


module "VPC" {
  source = "../Parent-Module"
  vpc_cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  Subnet-names = [ var.Subnet-names[0], var.Subnet-names[1], var.Subnet-names[2] , var.Subnet-names[3] ]
  subnet-cidr_block=[var.subnet-cidr_block[0], var.subnet-cidr_block[1], var.subnet-cidr_block[2], var.subnet-cidr_block[3]]
  Key-pair-name = var.key-pair-Name
  IGW_name= var.IGW_name
  instance-name =[var.instance-name[0], var.instance-name[1], var.instance-name[2], var.instance-name[3]]
  priv-rtb = var.priv-rtb


}