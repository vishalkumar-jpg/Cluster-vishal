# EKS Fargate Cluster — Terraform

This project provisions an **Amazon EKS cluster with Fargate** profiles using Terraform.

## Architecture

```
VPC (10.0.0.0/16)
├── Public Subnets  → Internet Gateway
│   ├── us-east-1a  (10.0.101.0/24)
│   └── us-east-1b  (10.0.102.0/24)
├── Private Subnets → NAT Gateway → Internet
│   ├── us-east-1a  (10.0.1.0/24)   ← Fargate pods
│   └── us-east-1b  (10.0.2.0/24)   ← Fargate pods
└── EKS Cluster
    ├── Fargate Profile: default
    └── Fargate Profile: kube-system
```

## Resources Created

| Resource | Description |
|---|---|
| VPC | Dedicated VPC with DNS support |
| Subnets | 2 public + 2 private across 2 AZs |
| NAT Gateway | Single NAT for private subnet internet access |
| EKS Cluster | Kubernetes control plane (v1.29) |
| Fargate Profiles | Serverless compute for selected namespaces |
| OIDC Provider | Enables IAM Roles for Service Accounts (IRSA) |
| IAM Roles | Cluster role + Fargate pod execution role |

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.3
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Quick Start

```bash
# 1. Initialize Terraform
terraform init

# 2. Review the plan
terraform plan

# 3. Apply
terraform apply

# 4. Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name cluster-vishal-eks

# 5. Verify
kubectl get nodes
```

## Customization

Edit `terraform.tfvars` to change:

- **Region / AZs** — `aws_region`, `availability_zones`
- **Network** — `vpc_cidr`, `private_subnet_cidrs`, `public_subnet_cidrs`
- **EKS version** — `cluster_version`
- **Fargate namespaces** — `fargate_namespaces` (add any namespace you want to run serverless)

## Cleanup

```bash
terraform destroy
```

> ⚠️ This will destroy all resources including the EKS cluster. Make sure to drain workloads first.
