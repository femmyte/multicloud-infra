output "network_attachment" {
  value = google_compute_network_attachment.network_attachment.self_link
}

output "network_id" {
  value = google_compute_network.vpc_network.id
}
output "network_self_link" {
  value = google_compute_network.vpc_network.self_link
}