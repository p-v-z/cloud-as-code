output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.subnet_public.id
}
output "ec2keyName" {
  value = aws_key_pair.ec2key.key_name
}