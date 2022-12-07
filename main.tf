resource "aws_internet_gateway" "create_internet_gateway" {
  count  = contains(["both", "internet"], var.gateway_type) ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name                  = var.name != null ? "${var.name}${var.gateway_type == "both" ? "-igtw" : ""}" : "tf-internet-gateway"
    "tf-internet-gateway" = var.name != null ? "${var.name}${var.gateway_type == "both" ? "-igtw" : ""}" : "tf-internet-gateway"
  })
}

resource "aws_eip" "create_static_ip_nat_allocation" {
  count = (var.connectivity_type == "public" && contains(["both", "nat"], var.gateway_type)) ? 1 : 0
  vpc   = true

  tags = merge(var.tags_eip, {
    Name    = "${var.name}-ip-nat-allocation"
    "tf-ip" = "${var.name}-ip-nat-allocation"
  })
}

resource "aws_nat_gateway" "create_nat_gateway" {
  count             = contains(["both", "nat"], var.gateway_type) ? 1 : 0
  allocation_id     = try(aws_eip.create_static_ip_nat_allocation[0].id, null)
  private_ip        = var.private_ip_id
  subnet_id         = var.subnet_id
  connectivity_type = var.connectivity_type

  tags = merge(var.tags, {
    Name             = var.name != null ? "${var.name}${var.gateway_type == "both" ? "-ngtw" : ""}" : "tf-nat-gateway"
    "tf-nat_gateway" = var.name != null ? "${var.name}${var.gateway_type == "both" ? "-ngtw" : ""}" : "tf-nat-gateway"
  })
}
