# AWS EKS

Terraform scripts for setting up the EKS cluster.

## Setup

### Initialize

```bash
terraform init
```

### Provision the cluster

```bash
make setup connect-eks
```

### Destroy the cluster and all resources

```bash
make destroy disconnect-eks
```
