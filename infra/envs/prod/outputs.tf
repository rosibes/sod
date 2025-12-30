output "elastic_ip" {
  value = module.compute.elastic_ip
}

output "public_dns" {
  value = module.compute.public_dns
}

output "instance_id" {
  value = module.compute.instance_id
}
