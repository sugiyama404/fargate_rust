variable "app_name" {
  description = "application name"
  type        = string
  default     = "todolist"
}

variable "web_app_name" {
  description = "webserver name"
  type        = string
  default     = "webserver"
}

variable "api_app_name" {
  description = "apiserver name"
  type        = string
  default     = "apiserver"
}

variable "web_app_dir_name" {
  description = "webserver directory name"
  type        = string
  default     = "webserver"
}

variable "api_app_dir_name" {
  description = "apiserver directory name"
  type        = string
  default     = "apserver"
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-northeast-1"
}

