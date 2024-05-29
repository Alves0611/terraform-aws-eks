locals {
  namespaced_service_name = var.service_name

  subnets = {
    "pub_a" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 1)
      az         = "a"
      name       = "public-a"
      public     = true
      tags       = {}
    }
    "pub_b" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 2)
      az         = "b"
      name       = "public-b"
      public     = true
      tags       = {}
    }
    "pub_c" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 3)
      az         = "c"
      name       = "public-c"
      public     = true
      tags       = {}
    }
    "pvt_a" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 4)
      az         = "a"
      name       = "private-a"
      public     = false
      tags       = {}
    }
    "pvt_b" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 5)
      az         = "b"
      name       = "private-b"
      public     = false
      tags       = {}
    }
    "pvt_c" = {
      cidr_block = cidrsubnet(var.cidr_block, 8, 6)
      az         = "c"
      name       = "private-c"
      public     = false
      tags       = {}
    }
  }

  subnet_ids = {
    for k, v in aws_subnet.this : v.tags.Name => v.id
  }
  public_subnet_ids   = [for k, v in local.subnets : aws_subnet.this[k].id if v.public]
  internet_cidr_block = "0.0.0.0/0"
}
