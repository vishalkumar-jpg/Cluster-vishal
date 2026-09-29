# =============================================================================
# Customize these values for your deployment
# =============================================================================

aws_region   = "us-west-1"
project_name = "cluster-vishal"
environment  = "dev"

vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-west-1a", "us-west-1b"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]

cluster_version = "1.29"

# Namespaces that will run on Fargate (add more as needed)
fargate_namespaces = ["default", "kube-system"]

tags = {
  Owner = "vishal"
}
