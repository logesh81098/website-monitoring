##############################################################################################################################
#                                       Security Group Module
##############################################################################################################################

resource "aws_security_group" "website-monitoring-server" {
  vpc_id = var.vpc-id
  description = "Security Group for Website Monitoring Server"
  ingress {
    from_port = var.port-ssh
    to_port = var.port-ssh
    protocol = "tcp"
    cidr_blocks = [var.my-ip]
    description = "Ingress Rule for SSH Port"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anywhere-ip ]
    description = "Egress rule to connect from Anywhere on Any IP Address"
  }
  tags = {
    Name = "Website Monitoring SG"
  }
}