variable "awsprofile" {
    type= string
}

variable "region" {
    type= string
}

variable "port1" {
    type= string
}

variable "port2" {
    type= string
}

variable "port3" {
    type= string
}

variable "cidr_block_1" {
    type= list(string)
}

variable "lbsgtag" {
    type= string
}

variable "jenkinsgtag" {
    type= string
}

variable "keyname" {
    type= string
}

variable "pubkey" {
    type = string
}

variable "instancetype" {
    type=string
}

variable "ec2_tag_name" {
    type = string
}

variable "domain_name" {
    type =string
}

variable "hostedzone" {
    type =string
}

variable "lbtype" {
    type = string
}

variable "albname" {
    type=string
}

variable "recordset" {
    type=list(string)
}

variable "r53recordset" {
    type=string
}

variable "emailid" {
    type=string
}