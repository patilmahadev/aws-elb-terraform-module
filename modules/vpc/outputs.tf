output "vpc_cidr_block" {
  value = aws_vpc.myvpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "public_subnet_id" {
  value = aws_subnet.mypubsub.id
}

output "private_subnet_id" {
  value = aws_subnet.myprisub.id
}