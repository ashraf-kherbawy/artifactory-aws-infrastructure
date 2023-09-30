resource "aws_security_group" "artifactory_rds_postgres_sg" {
  name_prefix = "artifactory_rds_postgres_sg"
  vpc_id = "vpc-041856119e9fa9666"
  
  # Allow incoming traffic from your EKS cluster's CIDR block on port 5432
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Replace with your VPC CIDR
  }

  tags = {
    provisioned_by = "ashrafk-terraform"
  }
}

resource "aws_db_subnet_group" "artifatory_rds_postgres_subnet_group" {
  name       = "artifatory_rds_postgres_subnet_group"
  subnet_ids = ["subnet-0121ff1e70acdb11a", "subnet-0c4010f0329a40ca0", "subnet-0b858936b0e92f433"]  # Replace with your subnet IDs in the same VPC as EKS
}

resource "aws_db_instance" "artifactory_rds_postgres" {
  identifier = "ashrafk-rds-psql"
  allocated_storage    = 20
  storage_type         = "gp2"
  storage_encrypted    = true
  engine               = "postgres"
  engine_version       = "13.12"
  instance_class       = "db.t3.small"
  db_name              = "artifactory"
  username             = "artifactory"
  password             = "password"
  parameter_group_name = "default.postgres13"
  db_subnet_group_name = aws_db_subnet_group.artifatory_rds_postgres_subnet_group.name
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.artifactory_rds_postgres_sg.id]

  tags = {
    provisioned_by = "ashrafk-terraform"
  }
}

output "database_endpoint" {
  value = aws_db_instance.artifactory_rds_postgres.endpoint
}

output "database_username" {
  value = aws_db_instance.artifactory_rds_postgres.username
}

output "database_password" {
  value = aws_db_instance.artifactory_rds_postgres.password
}