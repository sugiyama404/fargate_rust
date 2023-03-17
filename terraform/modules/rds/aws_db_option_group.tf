resource "aws_db_option_group" "mysql_standalone_optiongroup" {
  name                 = "db-standalone-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}
