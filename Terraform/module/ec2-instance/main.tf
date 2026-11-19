##############################################################################################################################
#                                           EC2 instance Module
##############################################################################################################################

resource "aws_instance" "website-monitoring-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  subnet_id = var.subnet-id
  vpc_security_group_ids = [var.security-group]
  key_name = var.keypair-name
  iam_instance_profile = var.instance-profile
  tags = {
    Name = "Website Monitoring Server"
  }
}