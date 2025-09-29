

# EKS Cluster + Managed Node Group

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.24" 

  cluster_name    = "shopedge-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa                    = true
  cluster_endpoint_public_access = true

  #  Managed Node Group
  eks_managed_node_groups = {
    default = {
      desired_size = 2
      min_size     = 1
      max_size     = 3

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      labels = {
        role = "worker"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# ECR Repository

resource "aws_ecr_repository" "app_repo" {
  name                 = "shop-edge"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
  }
}