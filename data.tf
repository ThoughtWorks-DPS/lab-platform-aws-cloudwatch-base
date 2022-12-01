data "aws_vpc" "cluster_vpc" {
  tags = {
    cluster = var.cluster_name
  }
}

data "aws_subnets" "intra" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.cluster_vpc.id]
  }

  tags = {
    Tier = "intra"
  }
}