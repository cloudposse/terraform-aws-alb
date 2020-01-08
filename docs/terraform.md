## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_logs_enabled | A boolean flag to enable/disable access_logs | bool | `true` | no |
| access_logs_prefix | The S3 log bucket prefix | string | `` | no |
| access_logs_region | The region for the access_logs S3 bucket | string | `us-east-1` | no |
| alb_access_logs_s3_bucket_force_destroy | A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error | bool | `false` | no |
| attributes | Additional attributes (_e.g._ "1") | list(string) | `<list>` | no |
| certificate_arn | The ARN of the default SSL certificate for HTTPS listener | string | `` | no |
| cross_zone_load_balancing_enabled | A boolean flag to enable/disable cross zone load balancing | bool | `true` | no |
| deletion_protection_enabled | A boolean flag to enable/disable deletion protection for ALB | bool | `false` | no |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| deregistration_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | number | `15` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | string | `` | no |
| health_check_healthy_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy | number | `2` | no |
| health_check_interval | The duration in seconds in between health checks | number | `15` | no |
| health_check_matcher | The HTTP response codes to indicate a healthy check | string | `200-399` | no |
| health_check_path | The destination for the health check request | string | `/` | no |
| health_check_timeout | The amount of time to wait in seconds before failing a health check request | number | `10` | no |
| health_check_unhealthy_threshold | The number of consecutive health check failures required before considering the target unhealthy | number | `2` | no |
| http2_enabled | A boolean flag to enable/disable HTTP/2 | bool | `true` | no |
| http_enabled | A boolean flag to enable/disable HTTP listener | bool | `true` | no |
| http_ingress_cidr_blocks | List of CIDR blocks to allow in HTTP security group | list(string) | `<list>` | no |
| http_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTP ingress security group | list(string) | `<list>` | no |
| http_port | The port for the HTTP listener | number | `80` | no |
| http_redirect | A boolean flag to enable/disable HTTP redirect to HTTPS | bool | `false` | no |
| https_enabled | A boolean flag to enable/disable HTTPS listener | bool | `false` | no |
| https_ingress_cidr_blocks | List of CIDR blocks to allow in HTTPS security group | list(string) | `<list>` | no |
| https_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTPS ingress security group | list(string) | `<list>` | no |
| https_port | The port for the HTTPS listener | number | `443` | no |
| https_ssl_policy | The name of the SSL Policy for the listener | string | `ELBSecurityPolicy-2015-05` | no |
| idle_timeout | The time in seconds that the connection is allowed to be idle | number | `60` | no |
| internal | A boolean flag to determine whether the ALB should be internal | bool | `false` | no |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | string | `ipv4` | no |
| name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `` | no |
| security_group_ids | A list of additional security group IDs to allow access to ALB | list(string) | `<list>` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `` | no |
| subnet_ids | A list of subnet IDs to associate with ALB | list(string) | - | yes |
| tags | Additional tags (_e.g._ { BusinessUnit : ABC }) | map(string) | `<map>` | no |
| target_group_additional_tags | The additional tags to apply to the target group | map(string) | `<map>` | no |
| target_group_name | The name for the default target group, uses a module label name if left empty | string | `` | no |
| target_group_port | The port for the default target group | number | `80` | no |
| target_group_target_type | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group | string | `ip` | no |
| vpc_id | VPC ID to associate with ALB | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| access_logs_bucket_id | The S3 bucket ID for access logs |
| alb_arn | The ARN of the ALB |
| alb_arn_suffix | The ARN suffix of the ALB |
| alb_dns_name | DNS name of ALB |
| alb_name | The ARN suffix of the ALB |
| alb_zone_id | The ID of the zone which ALB is provisioned |
| default_target_group_arn | The default target group ARN |
| http_listener_arn | The ARN of the HTTP forwarding listener |
| http_redirect_listener_arn | The ARN of the HTTP to HTTPS redirect listener |
| https_listener_arn | The ARN of the HTTPS listener |
| listener_arns | A list of all the listener ARNs |
| security_group_id | The security group ID of the ALB |

