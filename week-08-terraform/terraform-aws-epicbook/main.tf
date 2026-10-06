terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source                = "./modules/network"
  project_name          = var.project_name
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidr    = "10.0.1.0/24"
  private_subnet_a_cidr = "10.0.2.0/24"
  private_subnet_b_cidr = "10.0.3.0/24"
  my_ip_cidr            = var.my_ip_cidr
}

module "ec2" {
  source           = "./modules/ec2"
  project_name     = var.project_name
  public_subnet_id = module.network.public_subnet_id
  ec2_sg_id        = module.network.ec2_sg_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  public_key_path  = var.public_key_path
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  private_subnet_ids = module.network.private_subnet_ids
  rds_sg_id          = module.network.rds_sg_id
  db_instance_class  = var.db_instance_class
  engine_version     = var.engine_version
  db_username        = var.db_username
  db_password        = var.db_password
}
