module "network" {
  source             = "../../modules/network"
  name_prefix        = var.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  common_tags        = var.common_tags
}

module "compute" {
  source          = "../../modules/compute"
  name_prefix     = var.name_prefix
  vpc_id          = module.network.vpc_id
  subnet_id       = module.network.public_subnet_id
  admin_cidr      = var.admin_cidr
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_pair_name   = var.key_pair_name
  public_key_path = var.public_key_path
  common_tags     = var.common_tags
}
