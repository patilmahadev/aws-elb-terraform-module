module "myvpc1" {
  source = "./modules/vpc"
  region = var.region
  profile = var.profile
  prefix = "demo"
  vpc_cidr_block = "10.10.0.0/16"
  public_subnet_cidr_block = "10.10.1.0/24"
  private_subnet_cidr_block = "10.10.2.0/24"
}

module "myvpc2" {
  source = "./modules/vpc"
  region = var.region
  profile = var.profile
  prefix = "test"
  vpc_cidr_block = "172.20.0.0/16"
  public_subnet_cidr_block = "172.20.1.0/24"
  private_subnet_cidr_block = "172.20.2.0/24"
}

module "myelb1" {
  source = "./modules/elb"
  region = var.region
  profile = var.profile
  prefix = "demo"
  instance_type = var.instance_type
  ami = lookup(var.amis, var.region)
  public_key = file("mykey.pub")
  user_data = data.template_file.userdata.rendered
  vpc_cidr_block = module.myvpc1.vpc_cidr_block
  vpc_id = module.myvpc1.vpc_id
  public_subnet_id = module.myvpc1.public_subnet_id
  private_subnet_id = module.myvpc1.private_subnet_id
}

module "myelb2" {
  source = "./modules/elb"
  region = var.region
  profile = var.profile
  prefix = "test"
  instance_type = var.instance_type
  ami = lookup(var.amis, var.region)
  public_key = file("mykey.pub")
  user_data = data.template_file.userdata.rendered
  vpc_cidr_block = module.myvpc2.vpc_cidr_block
  vpc_id = module.myvpc2.vpc_id
  public_subnet_id = module.myvpc2.public_subnet_id
  private_subnet_id = module.myvpc2.private_subnet_id
}