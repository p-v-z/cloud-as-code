# output "sg_22_80_id" {
#   value = ["${aws_security_group.sg_22_80.id}"]
# }
output "vpc_security_group_ids" {
	value = [
		aws_security_group.sg_22.id,
		aws_security_group.sg_80.id
	]
}