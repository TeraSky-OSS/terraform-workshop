output "instances_ips" {
  value = aws_instance.web.*.public_ip
}

output "lb_dns" {
  value = aws_elb.web.dns_name
}