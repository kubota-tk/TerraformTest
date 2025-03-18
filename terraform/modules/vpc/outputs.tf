##他モジュールに出力

output "VPCID" {
  value = aws_vpc.vpc.id
}

output "Pub-SubA-ID" {
  value = aws_subnet.public_subnet_a.id
}

output "Pub-SubC-ID" {
  value = aws_subnet.public_subnet_c.id
}

output "Pri-SubA-ID" {
  value = aws_subnet.private_subnet_a.id
}

output "Pri-SubC-ID" {
  value = aws_subnet.private_subnet_c.id
}

