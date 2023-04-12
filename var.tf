variable "inst_type"{
    type = string
    description = "my aws instance type"
    default = "t2.micro"
}

/*variable "instance_name"{
    type = string
    description = "my aws instance"
    default = "my-ec2"
}*/

variable "key_pair"{
    type = string
    description = "my aws instance"
    default = "class29key"
}


variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80,8080, 9200, 9500]
}