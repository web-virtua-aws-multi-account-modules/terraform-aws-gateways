output "internet_gateway" {
  description = "Internet Gateway"
  value       = aws_internet_gateway.create_internet_gateway
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = try(aws_internet_gateway.create_internet_gateway[0].id, null)
}

output "internet_gateway_arn" {
  description = "Internet Gateway ARN"
  value       = try(aws_internet_gateway.create_internet_gateway[0].arn, null)
}

output "nat_gateway" {
  description = "NAT Gateway"
  value       = aws_nat_gateway.create_nat_gateway
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = try(aws_nat_gateway.create_nat_gateway[0].id, null)
}

output "nat_gateway_elastic_ip" {
  description = "NAT Gateway Elastic IP"
  value       = aws_eip.create_static_ip_nat_allocation
}
