#
# Variables Configuration
#

locals {
  environment = "development"

  prefix = "aws-101-${local.environment}"
  cluster-name = "${local.prefix}-cluster"
  worker-name = "${local.prefix}-worker"

  # See eks-worker-nodes.tf
  worker-instance-size = "t3.micro"

  # See eks-worker-nodes.tf
  max-worker-instances = 5
  desired-instances    = 3
  min-worker-instances = 2

  publicly-accessible = true
}
