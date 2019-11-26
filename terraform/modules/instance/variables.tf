variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-01f14919ba412de34"
}
variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

variable "vpc_id" {
  description = "VPC id"
  default = ""
}
variable "subnet_public_id" {
  description = "VPC public subnet id"
  default = ""
}
variable "key_pair_name" {
  description = "EC2 Key pair name"
  default = ""
}
variable "security_group_ids" {
  description = "EC2 ssh security group"
  type = list(string)
  default = []
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}