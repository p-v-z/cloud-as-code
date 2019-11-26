provider "aws" {
	region 	= var.region
	profile = var.profile
}

module "networkModule" {
    source			= "./modules/network"
	environment_tag = var.environment_tag
}

module "securityGroupModule" {
    source			= "./modules/security"
	vpc_id			= module.networkModule.vpc_id
	environment_tag = var.environment_tag
}

module "instanceModule" {
	source 				= "./modules/instance"
 	vpc_id 				= module.networkModule.vpc_id
	subnet_public_id	= module.networkModule.public_subnet_id
	key_pair_name		= module.networkModule.ec2keyName
	security_group_ids 	= module.securityGroupModule.vpc_security_group_ids
	environment_tag 	= var.environment_tag
}

module "dnsModule" {
	source 		= "./modules/dns"
	domain_name	= "pvz.ninja"
	aRecords	= [
		"pvz.ninja ${module.instanceModule.instance_eip}",
	]
	cnameRecords	= [
		"www.pvz.ninja pvz.ninja"
	]
}