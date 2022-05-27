resource "tls_private_key" "private_key" {
  algorithm = var.algorithm
  rsa_bits = var.rsa_bits
}

resource "aws_key_pair" "key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.private_key.public_key_openssh
  
  depends_on = [
    tls_private_key.private_key
  ]
}

resource "local_file" "ssh_key" {
    content  = tls_private_key.private_key.private_key_pem
    filename = "C:/Users/bala/Downloads/new_key_pair.pem"
}