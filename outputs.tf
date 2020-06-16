# output "ip" {
#   value = aws_eip.ip.public_ip
# }

output "instance_ip_addr_master" {
  value       = aws_instance.master.public_ip
  description = "The private IP address of the main server instance."
}

output "instance_ip_addr_worker_1" {
  value       = aws_instance.worker_1.public_ip
  description = "The private IP address of the main server instance."
}


output "instance_ip_addr_worker_2" {
  value       = aws_instance.worker_2.public_ip
  description = "The private IP address of the main server instance."
}
