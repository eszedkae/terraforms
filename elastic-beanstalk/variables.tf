##################################################
## Variables
##################################################
variable "profile" { default = "default"}
variable "aws_region" { default = "us-west-2"}
variable "name" { default = "e_beanstalk"}
variable "ebs_app_name" { default = "ebs_app_dev"}
variable "env_name" { default = "Beanstalk_Dev_Environment"}
variable "namespace" { default = "ebs_app_dev"}
variable "availability_zones" { default = ["us-west-2a", "us-west-2b", "us-west-2c"]}