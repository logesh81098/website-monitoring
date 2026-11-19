##############################################################################################################################
#                                              VPC Module
##############################################################################################################################

resource "aws_vpc" "website-monitoring" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Website Monitoring VPC"
  }
}


##############################################################################################################################
#                                              VPC - Subnet
##############################################################################################################################

#Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.website-monitoring.id
  cidr_block = var.public-subnet-cidr
  map_public_ip_on_launch = true
  availability_zone = var.az1
  tags = {
    Name = "Website Monitoring Public Subnet"
  }
}


#Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.website-monitoring.id
  cidr_block = var.private-subnet-cidr
  availability_zone = var.az1
  tags = {
    Name = "Website Monitoring Private Subnet"
  }
}

##############################################################################################################################
#                                              VPC - Gateways 
##############################################################################################################################

#Internet Gateway
resource "aws_internet_gateway" "website-monitoring-igw" {
  vpc_id = aws_vpc.website-monitoring.id
  tags = {
    Name = "Website Monitoring IGW"
  }
}


#Elastic IP for NAT Gateway
resource "aws_eip" "elastic-ip" {
  domain = "vpc"
  tags = {
    Name = "Website Monitoring Elastic IP"
  }
}

resource "aws_nat_gateway" "website-monitoring-nat" {
  subnet_id = aws_subnet.public-subnet.id
  allocation_id = aws_eip.elastic-ip.id
}

##############################################################################################################################
#                                              VPC - Route Tables 
##############################################################################################################################

#Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.website-monitoring.id
  route {
    gateway_id = aws_internet_gateway.website-monitoring-igw.id
    cidr_block = var.anywhere-ip
  }
  tags = {
    Name = "Website Monitoring Public RT"
  }
}


#Private Route Table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.website-monitoring.id
  route {
    gateway_id = aws_nat_gateway.website-monitoring-nat.id
    cidr_block = var.anywhere-ip
  }
  tags = {
    Name = "Website Monitoring Private RT"
  }
}

##############################################################################################################################
#                                         VPC - Route Table Association
##############################################################################################################################

#Public Route Table Association 
resource "aws_route_table_association" "public-rt-association" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public-subnet.id
}


#Private Route Table Association
resource "aws_route_table_association" "private-rt-association" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.private-subnet.id
}