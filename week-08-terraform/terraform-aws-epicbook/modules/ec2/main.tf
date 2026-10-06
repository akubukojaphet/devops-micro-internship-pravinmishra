data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.ec2_sg_id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")

  tags = { Name = "${var.project_name}-ec2" }
}
