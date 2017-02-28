output "ip" {
  value = "${aws_instance.rpm_repository.public_ip}"
}
