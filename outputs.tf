output "alb_arn" {
  value = "${aws_lb.default.arn}"
}

output "alb_arn_suffix" {
  value = "${aws_lb.default.arn_suffix}"
}

output "alb_dns_name" {
  value = "${aws_lb.default.dns_name}"
}

output "alb_canonical_hosted_zone_id" {
  value = "${aws_lb.default.canonical_hosted_zone_id}"
}

output "alb_zone_id" {
  value = "${aws_lb.default.zone_id}"
}

output "security_group_id" {
  value = "${aws_security_group.default.id}"
}

output "default_target_group_arn" {
  value = "${aws_lb_target_group.default.arn}"
}

output "http_listener_arn" {
  value = "${aws_lb_listener.http.arn}"
}

output "https_listener_arn" {
  value = "${aws_lb_listener.https.arn}"
}

output "listener_arns" {
  value = ["${aws_lb_listener.http.arn}"]
}

output "access_logs_bucket" {
  value = "${module.access_logs.bucket_id}"
}
