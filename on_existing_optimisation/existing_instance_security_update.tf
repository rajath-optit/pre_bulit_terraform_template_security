# Define provider
provider "aws" {
  region = "us-east-1" # Set AWS region
}

# Data source to get existing EC2 instances
data "aws_instances" "existing_instances" {
  # Filter instances based on tags
  instance_tags {
    Name = "my-existing-instance" # Replace with your instance name or tag
  }
}

# Security group for existing instances
resource "aws_security_group" "existing_instance_sg" {
  name        = "existing_instance_sg" # Set the name of the security group
  description = "Security group for existing instances" # Set description for the security group

  # Define ingress rules for the security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  # Define egress rules for the security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# Update existing instances with the new security group
resource "aws_instance" "existing_instances" {
  count = length(data.aws_instances.existing_instances.ids) # Count the number of existing instances found

  ami           = "ami-0c55b159cbfafe1f0" # Replace with your AMI
  instance_type = "t2.micro"

  # Set the security group for each existing instance
  security_groups = [aws_security_group.existing_instance_sg.name]

  # Set the instance ID for each existing instance found by the data source
  instance_id = data.aws_instances.existing_instances.ids[count.index]
}
