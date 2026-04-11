aws_region   = "us-east-1"
project_name = "foodfast"
environment  = "dev"
vpc_cidr     = "10.10.0.0/16"

public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]

availability_zones = ["us-east-1a", "us-east-1b"]

eks_cluster_name    = "foodfast-eks"
node_instance_types = ["t3.medium"]
desired_size        = 2
min_size            = 1
max_size            = 3

ecr_repositories = [
  "frontend",
  "restaurant-service",
  "menu-service",
  "order-service",
  "notification-worker"
]