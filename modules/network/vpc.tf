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
  map_public_ip_on_launch = each.value.public

  tags = merge(
    {
      "Name" = "${local.namespaced_service_name}-${each.value.name}"
    },
    each.value.tags
  )
}

resource "aws_nat_gateway" "this" {
  count = var.create_nat_gateway && var.nat_gateway_per_az ? length(local.public_subnet_ids) : (var.create_nat_gateway ? 1 : 0)

  allocation_id = aws_eip.this.*.id[count.index]
  subnet_id     = element(local.public_subnet_ids, count.index)
  tags = {
    "Name" = "${local.namespaced_service_name}-nat-gateway"
  }
}

resource "aws_eip" "this" {
  count = var.create_nat_gateway && var.nat_gateway_per_az ? length(local.public_subnet_ids) : (var.create_nat_gateway ? 1 : 0)

  domain = "vpc"
  tags = {
    "Name" = "${local.namespaced_service_name}-eip"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = var.create_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = var.nat_gateway_per_az ? element(aws_nat_gateway.this.*.id, 0) : aws_nat_gateway.this[0].id
    }
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-private"
  }
}

resource "aws_route_table_association" "this" {
  for_each = local.subnet_ids

  route_table_id = can(regex(".*\\bpublic\\b.*", each.key)) ? aws_route_table.public.id : aws_route_table.private.id
  subnet_id      = each.value
}
