resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "${var.project_name}-db-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  identifier             = "${var.project_name}-mysql"
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  multi_az               = false
  deletion_protection    = false
  skip_final_snapshot    = true

  tags = { Name = "${var.project_name}-mysql" }
}
