variable "vpc_cidr_block" {
    type = string
    default = "120.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = false
}

variable "Subnet-names" {
  type = list(string)
  default = [ "server-1" , "server-2" , "server-3" , "server-4" ]
}

variable "subnet-cidr_block" {
    type = list(string)
    default = [ "120.0.1.0/24","120.0.2.0/24", "120.0.3.0/24" , "120.0.4.0/24" ]
  
}

variable "key-pair-Name" {
    type =string
    default = "kwabena-key"

}

variable "IGW_name" {
    type =string
    default ="kwabena-igw"
  
}

variable "instance-name" {
    type = list(string)
    default = [ "kwabena-in-A","kwabena-in-B","kwabena-in-C", "kwabena-in-D"]
  
}
variable "priv-rtb" {
    type = string
    default = "kwabena-priv-rtb"
  
}