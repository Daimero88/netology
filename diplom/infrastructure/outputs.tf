output "network_id" {
  value       = yandex_vpc_network.main.id
  description = "ID of the created VPC network"
}

output "subnet_ids" {
  value = {
    "ru-central1-a" = yandex_vpc_subnet.subnet_a.id
    "ru-central1-b" = yandex_vpc_subnet.subnet_b.id
    "ru-central1-d" = yandex_vpc_subnet.subnet_d.id
  }
  description = "Map of subnet IDs by availability zone"
}

output "k8s_nodes_ips" {
  value = {
    for name, instance in yandex_compute_instance.k8s_nodes :
    name => instance.network_interface.0.nat_ip_address
  }
}
