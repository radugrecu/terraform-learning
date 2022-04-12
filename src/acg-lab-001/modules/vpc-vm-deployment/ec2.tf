data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "radug" {
  key_name   = "radug"
  public_key = file("../.ssh/id_rsa.pub")
}


resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = aws_subnet.subnets[var.subnet_cidrs[0]].id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.radug.key_name
  associate_public_ip_address = true
}



output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "aws_ip" {
  value = aws_instance.web.public_ip
}