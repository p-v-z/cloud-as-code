# Let us start an EC2 instance within our public subnet with created key pair and security group.
resource "aws_instance" "testInstance" {
	ami 					= var.instance_ami
	instance_type 			= var.instance_type
	subnet_id 				= var.subnet_public_id
	vpc_security_group_ids 	= var.security_group_ids
	key_name 				= var.key_pair_name

	tags = {
		Environment = var.environment_tag
	}
}

resource "aws_eip" "testInstanceEip" {
  vpc       = true
  instance  = aws_instance.testInstance.id

  tags = {
    Environment = var.environment_tag
  }
}

# Provisioner
# important! - Provisioners in terraform should be used as a last resort. Use Packer for provisioning
# resource "aws_instance" "testInstance" {
# 	ami = var.instance_ami
# 	instance_type = var.instance_type
# 	subnet_id = var.subnet_public_id
# 	vpc_security_group_ids = var.vpc_security_group_ids
# 	key_name = aws_key_pair.ec2key.key_name
# 	tags = {
# 		Environment = var.environment_tag
# 	}
# 	# A connection is used to create an SSH connection with user “ec2-user” and ssh private key 
# 	# from a specified path to run remote-exec inline commands.
# 	provisioner "remote-exec" {
# 		connection {
# 			type = "ssh"
# 			user = "ec2-user"
# 			password = ""
# 			host = self.public_ip
# 			private_key = file("~/.ssh/aws-tf")
# 			agent = false
# 		}
# 		inline = [
# 			"sudo amazon-linux-extras enable nginx1.12",
# 			"sudo yum -y install nginx",
# 			"sudo systemctl start nginx",
# 		] 
# 	}
# }