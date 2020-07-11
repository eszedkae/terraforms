##################################################
## Outputs
##################################################
output "vpc-id" {
    value = module.vpc.vpc_id
}
output "cidr" {
    value = module.vpc.vpc_cidr_block
}
output "elb_zone_id" {
    value = module.elastic_beanstalk_environment.elb_zone_id
}
output "endpoint" {
    value = module.elastic_beanstalk_environment.endpoint
}
output "instances" {
    value = module.elastic_beanstalk_environment.instances
}
output "load_balancers" {
    value = module.elastic_beanstalk_environment.load_balancers
}