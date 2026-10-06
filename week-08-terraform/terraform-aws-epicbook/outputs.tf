output "ec2_public_ip" {
  description = "Public IP of the EpicBook server"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "Private RDS MySQL endpoint"
  value       = module.rds.rds_endpoint
}
