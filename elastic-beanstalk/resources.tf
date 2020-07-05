##################################################
## AWS config
##################################################

provider "aws" {
    profile                 = var.profile
    shared_credentials_file = "~/.aws/credentials"
    region                  = var.aws_region
}

module "vpc" {
    source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.8.0"
    name       = var.name
    cidr_block = "172.16.0.0/16"
}
module "subnets" {
    source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.16.0"
    availability_zones   = var.availability_zones
    name                 = var.name
    vpc_id               = module.vpc.vpc_id
    igw_id               = module.vpc.igw_id
    cidr_block           = module.vpc.vpc_cidr_block
    nat_gateway_enabled  = true
    nat_instance_enabled = false
}

##################################################
## Elastic BeanStalk config
##################################################

module "elastic_beanstalk_application" {
    source      = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.3.0"
    name        = var.ebs_app_name
    description = "elastic_beanstalk_application"
  }

module "elastic_beanstalk_environment" {
    source                             = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=master"
    namespace                          = var.namespace
    name                               = var.env_name
    description                        = "Test elastic_beanstalk_environment"
    region                             = var.aws_region
    availability_zone_selector         = "Any 2"
    elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name

    instance_type           = "t2.micro"
    autoscale_min           = 1
    autoscale_max           = 2
    updating_min_in_service = 0
    updating_max_batch      = 1
    loadbalancer_type       = "application"
    vpc_id                  = module.vpc.vpc_id
    loadbalancer_subnets    = module.subnets.public_subnet_ids
    application_subnets     = module.subnets.private_subnet_ids
    solution_stack_name     = "64bit Amazon Linux 2018.03 v4.15.0 running Node.js"
}

