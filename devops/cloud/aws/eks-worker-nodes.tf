#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EC2 Security Group to allow networking traffic
#  * Data source to fetch latest EKS worker AMI
#  * AutoScaling Launch Configuration to configure worker instances
#  * AutoScaling Group to launch worker instances
#

resource "aws_iam_role" "aws-101-worker-iam-role" {
  name = "${local.worker-name}-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-101-worker-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.aws-101-worker-iam-role.name
}

resource "aws_iam_role_policy_attachment" "aws-101-worker-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.aws-101-worker-iam-role.name
}

resource "aws_iam_role_policy_attachment" "aws-101-worker-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.aws-101-worker-iam-role.name
}

resource "aws_iam_instance_profile" "aws-101-worker-iam-instance-profile" {
  name        = "${local.worker-name}-iam-instance-profile"
  role        = aws_iam_role.aws-101-worker-iam-role.name
}

resource "aws_security_group" "aws-101-worker-sg" {
  name        = "${local.worker-name}-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.aws-101-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = map(
    "Name", "${local.worker-name}-sg",
    "kubernetes.io/cluster/${local.cluster-name}", "owned",
  )
}

resource "aws_security_group_rule" "aws-101-worker-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-101-worker-sg.id
  source_security_group_id = aws_security_group.aws-101-worker-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "aws-101-worker-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.aws-101-worker-sg.id
  source_security_group_id = aws_security_group.aws-101-cluster-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

data "aws_ami" "aws-101-eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.aws-101-eks-cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  aws-101-worker-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.aws-101-eks-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.aws-101-eks-cluster.certificate_authority.0.data}' '${local.cluster-name}'
USERDATA
}

# TODO: Instance type map?
resource "aws_launch_configuration" "aws-101-worker-lc" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.aws-101-worker-iam-instance-profile.name
  image_id                    = data.aws_ami.aws-101-eks-worker.id
  instance_type               = local.worker-instance-size
  name_prefix                 = local.worker-name
  security_groups             = [aws_security_group.aws-101-worker-sg.id]
  user_data_base64            = base64encode(local.aws-101-worker-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "aws-101-autoscaling-group" {
  launch_configuration = aws_launch_configuration.aws-101-worker-lc.id
  desired_capacity     = local.desired-instances
  max_size             = local.max-worker-instances
  min_size             = local.min-worker-instances
  name                 = "${local.worker-name}-autoscaling-group"
  vpc_zone_identifier  = aws_subnet.aws-101-subnet[*].id

  tag {
    key                 = "Name"
    value               = "${local.worker-name}-autoscaling-group"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${local.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
