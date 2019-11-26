variable "domain_name" {
  description = "Domain name"
  default = ""
}
variable "aRecords" {
  type = list(string)
  default = []
}
variable "cnameRecords" {
  type = list(string)
  default = []
}
variable "ttl" {
  description = "time to live"
  default = 300
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}