terraform {
  backend "s3" {
    bucket         = "tf-class-01-state-bucket-01"
    key            = "projects_eks/terraform.tfstate"
    encrypt        = true
    region         = "us-east-1"
    dynamodb_table = "tf-class-01-tf-lock"
  }
}


module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  cluster_name         = var.cluster_name

}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_groups     = var.node_groups
}