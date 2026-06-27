provider "aws" {
    region = "us-east-1" # set your desired aws region
}

resource "aws_instance" "example" {
  ami                     = "ami-0b6d9d3d33ba97d00"
  instance_type           = "t2.micro"
   
}