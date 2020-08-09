#
# Provider Configuration
#

provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

# TODO: Define multiple availability zones for Prod
data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}
