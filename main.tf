provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
}

resource "aws_instance" "devops_server" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"

  tags = {
    Name = "DevOps-Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:5000 $DOCKER_USERNAME/flask-app:latest
              EOF
}

output "public_ip" {
  value = aws_instance.devops_server.public_ip
}
