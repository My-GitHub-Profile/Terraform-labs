resource "aws_key_pair" "autokey" {
 key_name   = "autokey"
 public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
 algorithm = "RSA"
 rsa_bits  = 4096
}

resource "null_resource" "get_keys" {
 provisioner "local-exec" {
  command     = "echo '${tls_private_key.rsa.public_key_openssh}' > ./public_key.rsa"
  }

 provisioner "local-exec" {
  command     = "echo '${tls_private_key.rsa.private_key_pem}' > ./private_key.pem"
  }
}

########## optional
resource "local_file" "key" {
 content  = tls_private_key.rsa.private_key_pem
 filename = "autokey"
}
##########
