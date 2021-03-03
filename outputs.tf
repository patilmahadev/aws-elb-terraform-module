output "vpc1_elb_dns" {
  value = module.myelb1.elb_dns
}

output "vpc2_elb_dns" {
  value = module.myelb2.elb_dns
}