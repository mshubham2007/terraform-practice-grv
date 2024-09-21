# Create an EC2 Key Pair
resource "tls_private_key" "ec2-auth-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "public_key"
  public_key = tls_private_key.ec2-auth-key.public_key_openssh

  tags = {
    Name = "my_key_pair"
  }
}

# Output the private key to a local file (make sure to secure this!)
output "private_key_pem" {
  value     = tls_private_key.ec2-auth-key.private_key_pem
  sensitive = true
}

# Optionally write the private key to a local file
resource "local_file" "private_key" {
  filename = "private_key.pem"
  content  = tls_private_key.ec2-auth-key.private_key_pem
  file_permission = "0600"
}
