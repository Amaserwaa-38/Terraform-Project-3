output "Boafoa-VPC" {
  value = aws_vpc.aseda.id
}

output "Boafoa-IGW" {
  value = aws_internet_gateway.aseda-igw.id
}

output "Boafoa-subnet-2" {
  value = aws_subnet.aseda-sub[2].id

}
output "Boafoa-db-instance-group" {
  value = aws_db_subnet_group.aseda-db-sub-G.id

}

output "Boafoa-instance-3" {
  value = aws_instance.aseda-ec2[3].id

}


