#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "aws-101-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = local.publicly-accessible

  tags = map(
    "Name", "${local.prefix}-vpc",
    "kubernetes.io/cluster/${local.cluster-name}", "shared",
  )
}

resource "aws_subnet" "aws-101-subnet" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.aws-101-vpc.id

  tags = map(
    "Name", "${local.prefix}-subnet",
    "kubernetes.io/cluster/${local.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "aws-101-ig" {
  vpc_id = aws_vpc.aws-101-vpc.id

  tags = {
    Name = local.prefix
  }
}

resource "aws_route_table" "aws-101-rt" {
  vpc_id = aws_vpc.aws-101-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-101-ig.id
  }
}

resource "aws_route_table_association" "aws-101-rta" {
  count = 2

  subnet_id      = aws_subnet.aws-101-subnet.*.id[count.index]
  route_table_id = aws_route_table.aws-101-rt.id
}
