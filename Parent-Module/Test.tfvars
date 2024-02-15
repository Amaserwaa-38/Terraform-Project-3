

region            = "eu-west-1"
Project-name      = "Website"
vpc_cidr_block    = "120.0.0.0/16"
instance_tenancy  = "default"
subnet-cidr_block = ["120.0.1.0/24", "120.0.2.0/24", "120.0.3.0/24", "120.0.4.0/24"]
instance_type     = "t2.Micro"
RDS-name = "asda-db-instance"
Sub-name = "asda-SG"
Key-pair-name = "asda-key"