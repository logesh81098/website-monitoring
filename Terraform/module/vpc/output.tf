output "vpc-id" {
  value = aws_vpc.website-monitoring.id
}

output "public-subnet-id" {
  value = aws_subnet.public-subnet.id
}