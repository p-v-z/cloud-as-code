# We are going to create VPC with defined CIDR block, enable DNS support and DNS hostnames so each instance can have a DNS name along with IP address.
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
	Environment = var.environment_tag
  }
}

# Internet gateway needs to be added inside VPC which can be used by subnet to access the internet from inside.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
	Environment = var.environment_tag
  }
}

# The subnet is added inside VPC with its own CIDR block which is a subset of VPC CIDR block inside given availability zone.
resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
  
  tags = {
	Environment = var.environment_tag
	Type = "Public"
  }
}

# Route table needs to be added which uses internet gateway to access the internet.
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
	Environment = var.environment_tag
  }
}

# Once route table is created, we need to associate it with the subnet to make our subnet public.
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

# Let’s create a key pair which we are going to use to SSH on our EC2
resource "aws_key_pair" "ec2key" {
	key_name = "publicKey"
	public_key = file(var.public_key_path)
}