variable "aws_region" {
  type        = string
  description = "AWS Region (same one used in aws configure)"
}

variable "project_name" {
  type = string
}

variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR form, used for SSH access"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair created in AWS"
}

variable "public_key_path" {
  type        = string
  description = "Path to your local PUBLIC key (.pub)"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "engine_version" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
