locals {
  public_subnet_args = {
    "ap-northeast-1a" = "10.0.0.0/24"
    "ap-northeast-1c" = "10.0.1.0/24"
    "ap-northeast-1d" = "10.0.2.0/24"
  }
  private_subnet_args = {
    "ap-northeast-1a" = "10.0.10.0/24"
    "ap-northeast-1c" = "10.0.11.0/24"
    "ap-northeast-1d" = "10.0.12.0/24"
  }
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "udemy-terraform-vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnet_args

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_args

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.this.id
}

resource "aws_route" "private" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = var.nat_gateway_count == 1 ? (
    aws_nat_gateway.this["ap-northeast-1a"].id
  ) : (
    aws_nat_gateway.this[each.key].id
  )
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_eip" "nat" {
  for_each = var.nat_gateway_count == 1 ? {
    "ap-northeast-1a" = aws_subnet.public["ap-northeast-1a"]
  } : aws_subnet.public
}

resource "aws_nat_gateway" "this" {
  for_each = var.nat_gateway_count == 1 ? {
    "ap-northeast-1a" = aws_subnet.public["ap-northeast-1a"]
  } : aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  depends_on = [
    aws_internet_gateway.this
  ]
}