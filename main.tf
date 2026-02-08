# 3. Use a Data Source to find the latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# 4. Create the EC2 Instance
resource "aws_instance" "my_first_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro" # Free tier eligible

  tags = {
    Name = "Terraform-Example-Instance"
  }
}

# 5. Output the public IP address so you can see it easily
output "instance_public_ip" {
  value = aws_instance.my_first_server.public_ip
}