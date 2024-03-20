# rds_instance.tf
resource "aws_db_instance" "mydb" {
  identifier            = "mydb"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t2.micro"
  name                  = "mydb"
  username              = "admin"
  password              = "password"
  db_subnet_group_name  = aws_db_subnet_group.mydb_subnet.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

resource "aws_db_subnet_group" "mydb_subnet" {
  name       = "mydb_subnet"
  subnet_ids = [aws_subnet.private_subnet.id]
}
