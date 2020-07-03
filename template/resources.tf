##################################################
## AWS config
##################################################

provider "aws" {
    profile =                 "${var.profile}"
    shared_credentials_file = "~/.aws/credentials"
    region =                  "${var.aws_region}"
}





##################################################
## Elastic Beanstalk config
##################################################