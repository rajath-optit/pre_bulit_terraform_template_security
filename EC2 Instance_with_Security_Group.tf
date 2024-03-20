# ec2_instance.tf
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Change AMI ID to desired OS
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_sg.name]
}
