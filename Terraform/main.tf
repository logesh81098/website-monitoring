module "vpc" {
  source = "./module/vpc"
}

module "security-groups" {
  source = "./module/security-groups"
  vpc-id = module.vpc.vpc-id
}

module "key-pair" {
  source = "./module/key-pair"
}

module "iam" {
  source = "./module/iam"
}

module "ec2-instance" {
  source = "./module/ec2-instance"
  subnet-id = module.vpc.public-subnet-id
  security-group = module.security-groups.security-group
  keypair-name = module.key-pair.keypair
  instance-profile = module.iam.instance-profile
}