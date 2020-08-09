#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "aws-101-cluster-iam-role" {
  name = "${local.cluster-name}-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-101-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws-101-cluster-iam-role.name
}

resource "aws_iam_role_policy_attachment" "aws-101-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws-101-cluster-iam-role.name
}

resource "aws_security_group" "aws-101-cluster-sg" {
  name        = "${local.cluster-name}-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.aws-101-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.cluster-name}-sg"
  }
}

resource "aws_security_group_rule" "aws-101-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.aws-101-cluster-sg.id
  source_security_group_id = aws_security_group.aws-101-worker-sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "aws-101-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.aws-101-cluster-sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "aws-101-eks-cluster" {
  name     = local.cluster-name
  role_arn = aws_iam_role.aws-101-cluster-iam-role.arn

  version =  "1.17"

  vpc_config {
    security_group_ids = [aws_security_group.aws-101-cluster-sg.id]
    subnet_ids         = aws_subnet.aws-101-subnet[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.aws-101-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.aws-101-cluster-AmazonEKSServicePolicy,
  ]
}
