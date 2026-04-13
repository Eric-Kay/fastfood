
module "vpc" {
  source               = "../../modules/vpc"
  project_name         = var.project_name
  environment          = var.environment
  cluster_name         = var.eks_cluster_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source              = "../../modules/eks"
  cluster_name        = var.eks_cluster_name
  project_name        = var.project_name
  environment         = var.environment
  subnet_ids          = module.vpc.private_subnet_ids
  vpc_id              = module.vpc.vpc_id
  node_instance_types = var.node_instance_types
  desired_size        = var.desired_size
  min_size            = var.min_size
  max_size            = var.max_size
}


module "ebs_csi" {
  source = "../../modules/ebs-csi"

  cluster_name    = module.eks.cluster_name
  oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  tags = {
    Project     = "foodfast"
    Environment = "dev"
  }

  depends_on = [module.eks]
}

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
  environment  = var.environment
  repositories = var.ecr_repositories
}

module "ingress" {
  source = "../../modules/ingress"

  depends_on = [module.eks]
}

module "monitoring" {
  source = "../../modules/monitoring"

  depends_on = [module.eks]
}