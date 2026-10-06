variable "project_name" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Name for the AWS key pair"
}

variable "public_key_path" {
  type        = string
  description = "Path to the local public key file"
}
