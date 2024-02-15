provider "aws" {
  region = var.region
}


resource "aws_vpc" "aseda" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc-Name
  }
}

data "aws_availability_zones" "AZ" {}


resource "aws_subnet" "aseda-sub" {
  vpc_id            = aws_vpc.aseda.id
  cidr_block        = var.subnet-cidr_block[count.index]
  count             = length(var.Subnet-names)
  availability_zone = element(data.aws_availability_zones.AZ.names, count.index)
  //availability_zone = data.aws_availabilty_zones.AZ.names[count.index]


  tags = {
    Name = var.Subnet-names[count.index]
  }
}

resource "aws_route_table" "aseda-pub-rtb" {
  vpc_id = aws_vpc.aseda.id


  tags = {
    Name = var.pub-rtb
  }
}


resource "aws_route_table" "aseda-priv-rtb" {
  vpc_id = aws_vpc.aseda.id


  tags = {
    Name = var.priv-rtb

  }
}

resource "aws_route_table_association" "aseda-pub-rtb-association-1" {
  subnet_id      = aws_subnet.aseda-sub[0].id
  route_table_id = aws_route_table.aseda-pub-rtb.id

}


resource "aws_route_table_association" "aseda-pub-rtb-association-2" {
  subnet_id      = aws_subnet.aseda-sub[1].id
  route_table_id = aws_route_table.aseda-pub-rtb.id

}


resource "aws_route_table_association" "aseda-priv-rtb-association-1" {
  subnet_id      = aws_subnet.aseda-sub[2].id
  route_table_id = aws_route_table.aseda-priv-rtb.id

}

resource "aws_route_table_association" "aseda-priv-rtb-association-2" {
  subnet_id      = aws_subnet.aseda-sub[3].id
  route_table_id = aws_route_table.aseda-priv-rtb.id

}

resource "aws_internet_gateway" "aseda-igw" {
  vpc_id = aws_vpc.aseda.id

  tags = {
    Name = var.IGW_name
  }
}


resource "aws_route" "IGW-association" {
  route_table_id         = aws_route_table.aseda-pub-rtb.id
  destination_cidr_block = var.IGW-cidr_block
  gateway_id             = aws_internet_gateway.aseda-igw.id

  depends_on = [aws_route_table.aseda-pub-rtb]

}

resource "aws_eip" "aseda-EIP" {

}


resource "aws_nat_gateway" "aseda-NGW" {
  allocation_id = aws_eip.aseda-EIP.id
  subnet_id     = aws_subnet.aseda-sub[0].id

  tags = {
    Name = var.NGW-Name
  }
}


resource "aws_route" "NAT-association" {
  route_table_id         = aws_route_table.aseda-priv-rtb.id
  destination_cidr_block = var.IGW-cidr_block
  gateway_id             = aws_nat_gateway.aseda-NGW.id



}


resource "aws_instance" "aseda-ec2" {
  ami                    = "ami-0cfd0973db26b893b" # amazon linux 2023
  instance_type          = "t2.micro"
  count                  = length(var.instance-name)
  subnet_id              = aws_subnet.aseda-sub[count.index].id
  key_name               = "boafoa-key"
  vpc_security_group_ids = [aws_security_group.aseda-SG.id]
  depends_on             = [aws_key_pair.aseda-key]

  tags = {
    Name = var.instance-name[count.index]

  }

}
resource "aws_key_pair" "aseda-key" {
  key_name   = "boafoa-key"
  public_key = file("boafoa-key.pub")

}


resource "aws_security_group" "aseda-SG" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.aseda.id

  dynamic "ingress" {
    for_each = var.ingress-SG
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  dynamic "egress" {
    for_each = var.egress-SG
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}


resource "aws_db_subnet_group" "aseda-db-sub-G" {
  name       = "main"
  subnet_ids = [aws_subnet.aseda-sub[2].id, aws_subnet.aseda-sub[3].id]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_instance" "aseda-db-instance" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "ab12345678"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.RDS-SG.id]
  db_subnet_group_name   = aws_db_subnet_group.aseda-db-sub-G.name
  //db_subnet_group_name = 
}




resource "aws_security_group" "RDS-SG" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.aseda.id

  dynamic "ingress" {
    for_each = var.ingress-name
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }



  dynamic "egress" {
    for_each = var.egress-name
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}





/*ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}*/