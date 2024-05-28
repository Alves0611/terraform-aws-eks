resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_subnet" "this" {
  for_each = local.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${data.aws_region.current.name}${each.value.az}"
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = "${local.namespaced_service_name}-${each.value.name}"
    },
    can(regex(".*\\bpublic\\b.*", each.value.name)) ? { "kubernetes.io/role/elb" = "1" } : {},
    can(regex(".*\\bprivate\\b.*", each.value.name)) ? { "kubernetes.io/role/internal-elb" = "1" } : {}
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = local.internet_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${local.namespaced_service_name}-private"
  }
}

resource "aws_route_table_association" "this" {
  for_each = local.subnet_ids

  route_table_id = can(regex(".*\\bpublic\\b.*", each.key)) ? aws_route_table.public.id : aws_route_table.private.id
  subnet_id      = each.value
}
