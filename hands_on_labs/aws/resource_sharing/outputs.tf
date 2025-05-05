output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "ram_resource_share_arn" {
  description = "ARN of the RAM resource share"
  value       = try(aws_ram_resource_share.subnets[0].arn, null)
}

output "ram_resource_share_id" {
  description = "ID of the RAM resource share"
  value       = try(aws_ram_resource_share.subnets[0].id, null)
}