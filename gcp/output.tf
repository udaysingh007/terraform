output "project_id" {
  value = google_project.project.project_id
}

output "vpc_network_name" {
  value = google_compute_network.vpc.name
}

output "vm_instance_name" {
  value = google_compute_instance.vm.name
}
