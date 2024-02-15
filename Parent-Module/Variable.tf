variable "region" {
  type        = string
  description = "vpc-region"
  default     = "eu-west-2"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc-cider_block"
  default     = "10.0.0.0/16"

}

variable "instance_tenancy" {
  type        = string
  description = "instance_tenancy"
  default     = "default"

}

variable "enable_dns_hostnames" {
  type        = bool
  description = "enable_dns_hostnames"
  default     = true
}

variable "vpc-Name" {
  type        = string
  description = "vpc-name"
  default     = "kenny-vpc"
}


variable "Project-name" {
  type    = string
  default = "Cloudrock"
}

variable "subnet-cidr_block" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]

}

variable "Subnet-names" {
  type    = list(string)
  default = ["web-sub-1", "web-sub-2", "app-sub-1", "app-sub-2"]

}
variable "pub-rtb" {
  type    = string
  default = "boafoa-pub-rtb"

}


variable "priv-rtb" {
  type    = string
  default = "boafoa-priv-rtb"

}

variable "Sub-name" {
  type    = string
  default = "Cloudrock-subnet"
}


variable "IGW_name" {
  type    = string
  default = "boafoa-igw"
}

variable "IGW-cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "NGW-Name" {
  type    = string
  default = "boafoa-NGW"

}

variable "instance-name" {
  type    = list(string)
  default = ["boafoa-instance-1", "boafoa-instance-2", "boafoa-instance-3", "boafoa-instance-4"]

}

variable "ingress-SG" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [{
    description = "allows-ssh"
    port        = 22
    }, {
    description = "allows-http"
    port        = 80
  }]
}

variable "egress-SG" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [{
    description = "allows-outbound-traffic"
    port        = 0
  }]

}


variable "ingress-name" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [{
    description = "allows-ssh"
    port        = 22
    }, {
    description = "allows-http"
    port        = 80
    }, {
    description = "MySQL-port"
    port        = 3306
  }]


}

variable "egress-name" {
  type = list(object({
    description = string
    port        = number
  }))
  default = [{
    description = "allows-outbound-traffic"
    port        = 0
  }]

}


variable "Key-pair-name" {
  type    = string
  default = "boafoa-key"

}


variable "SG-Name" {
  type    = string
  default = "aseda-SG"

}

variable "RDS-name" {
  type    = string
  default = "aseda-db-instance"

}


variable "instance_type" {
  type = string
  default = "t2.micro"

}








