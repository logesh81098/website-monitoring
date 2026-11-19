##############################################################################################################################
#                                           Key Pair Module
##############################################################################################################################

resource "tls_private_key" "server-key" {
  algorithm = "RSA"
  rsa_bits = 4098
}


resource "aws_key_pair" "website-monitoring-server-key" {
  key_name = "Website Monitoring Server Key"
  public_key = tls_private_key.server-key.public_key_openssh
}


resource "local_file" "pem-file" {
  filename = "Website-Monitoring-Server.pem"
  content = tls_private_key.server-key.private_key_openssh
}