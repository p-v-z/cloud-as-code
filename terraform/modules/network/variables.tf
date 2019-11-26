variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "eu-west-1a"
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}
variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/aws-tf.pub"
}