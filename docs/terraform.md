## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_logs_enabled | A boolean flag to enable/disable access_logs | string | `true` | no |
| access_logs_prefix | The S3 bucket prefix | string | `` | no |
| access_logs_region | The region for the access_logs S3 bucket | string | `us-east-1` | no |
| alb_access_logs_s3_bucket_force_destroy | A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error | string | `false` | no |
| attributes | Additional attributes, e.g. `1` | list | `<list>` | no |
| certificate_arn | The ARN of the default SSL certificate for HTTPS listener | string | `` | no |
| cross_zone_load_balancing_enabled | A boolean flag to enable/disable cross zone load balancing | string | `true` | no |
| deletion_protection_enabled | A boolean flag to enable/disable deletion protection for ALB | string | `false` | no |
| delimiter | Delimiter to be used between `namespace`, `name`, `stage` and `attributes` | string | `-` | no |
| deregistration_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | string | `15` | no |
| health_check_healthy_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy | string | `2` | no |
| health_check_interval | The duration in seconds in between health checks | string | `15` | no |
| health_check_matcher | The HTTP response codes to indicate a healthy check | string | `200-399` | no |
| health_check_path | The destination for the health check request | string | `/` | no |
| health_check_timeout | The amount of time to wait in seconds before failing a health check request | string | `10` | no |
| health_check_unhealthy_threshold | The number of consecutive health check failures required before considering the target unhealthy | string | `2` | no |
| http2_enabled | A boolean flag to enable/disable HTTP/2 | string | `true` | no |
| http_enabled | A boolean flag to enable/disable HTTP listener | string | `true` | no |
| http_ingress_cidr_blocks | List of CIDR blocks to allow in HTTP security group | list | `<list>` | no |
| http_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTP ingress security group | list | `<list>` | no |
| http_port | The port for the HTTP listener | string | `80` | no |
| https_enabled | A boolean flag to enable/disable HTTPS listener | string | `false` | no |
| https_ingress_cidr_blocks | List of CIDR blocks to allow in HTTPS security group | list | `<list>` | no |
| https_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTPS ingress security group | list | `<list>` | no |
| https_port | The port for the HTTPS listener | string | `443` | no |
| https_ssl_policy | The name of the SSL Policy for the listener. | string | `ELBSecurityPolicy-2015-05` | no |
| idle_timeout | The time in seconds that the connection is allowed to be idle | string | `60` | no |
| internal | A boolean flag to determine whether the ALB should be internal | string | `false` | no |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | string | `ipv4` | no |
| name | Solution name, e.g. `app` | string | - | yes |
| namespace | Namespace, which could be your organization name, e.g. `cp` or `cloudposse` | string | - | yes |
| security_group_ids | A list of additional security group IDs to allow access to ALB | list | `<list>` | no |
| stage | Stage, e.g. `prod`, `staging`, `dev`, or `test` | string | - | yes |
| subnet_ids | A list of subnet IDs to associate with ALB | list | - | yes |
| tags | Additional tags (e.g. `map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| target_group_port | The port for the default target group | string | `80` | no |
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
| http_listener_arn | The ARN of the HTTP listener |
| https_listener_arn | The ARN of the HTTPS listener |
| listener_arns | A list of all the listener ARNs |
| security_group_id | The security group ID of the ALB |

