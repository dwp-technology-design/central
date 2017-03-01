output "ip" {
  value = "${aws_instance.rpm_repository.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.rpm_repository.id}"
}
