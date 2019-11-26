output "public_instance_ip" {
  value = [module.instanceModule.instance_eip]
}