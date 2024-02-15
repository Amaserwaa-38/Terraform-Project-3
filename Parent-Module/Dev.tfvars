

region            = "eu-west-2"
Project-name      = "e-learning"
vpc_cidr_block    = "40.0.0.0/16"
instance_tenancy  = "default"
subnet-cidr_block = ["40.0.1.0/24", "40.0.2.0/24", "40.0.3.0/24", "40.0.4.0/24"]
instance_type     = "t2.Micro"
RDS-name = "aldi-db-instance"
Sub-name = "aldi-SG"
Key-pair-name = "aldi-key"