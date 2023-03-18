resource "aws_db_option_group" "main_optiongroup" {
  name                 = "rust-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}
