<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 2.54 |
| local | >= 1.3 |
| null | >= 2.0 |
| template | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.54 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| access_logs | cloudposse/lb-s3-bucket/aws | 0.11.3 |
| default_target_group_label | cloudposse/label/null | 0.24.1 |
| this | cloudposse/label/null | 0.24.1 |

## Resources

| Name |
|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) |
| [aws_lb_listener_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Modules

| Name | Source | Version |
|------|--------|---------|
| access_logs | cloudposse/lb-s3-bucket/aws | 0.11.4 |
| default_target_group_label | cloudposse/label/null | 0.24.1 |
| this | cloudposse/label/null | 0.24.1 |

## Resources

| Name |
|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) |
| [aws_lb_listener_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs\_enabled | A boolean flag to enable/disable access\_logs | `bool` | `true` | no |
| access\_logs\_prefix | The S3 log bucket prefix | `string` | `""` | no |
| additional\_certs | A list of additonal certs to add to the https listerner | `list(string)` | `[]` | no |
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| alb\_access\_logs\_s3\_bucket\_force\_destroy | A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| certificate\_arn | The ARN of the default SSL certificate for HTTPS listener | `string` | `""` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| cross\_zone\_load\_balancing\_enabled | A boolean flag to enable/disable cross zone load balancing | `bool` | `true` | no |
| deletion\_protection\_enabled | A boolean flag to enable/disable deletion protection for ALB | `bool` | `false` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| deregistration\_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | `number` | `15` | no |
| drop\_invalid\_header\_fields | Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). | `bool` | `false` | no |
| enable\_glacier\_transition | Enables the transition of lb logs to AWS Glacier | `bool` | `true` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| expiration\_days | Number of days after which to expunge s3 logs | `number` | `90` | no |
| glacier\_transition\_days | Number of days after which to move s3 logs to the glacier storage tier | `number` | `60` | no |
| health\_check\_healthy\_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2` | no |
| health\_check\_interval | The duration in seconds in between health checks | `number` | `15` | no |
| health\_check\_matcher | The HTTP response codes to indicate a healthy check | `string` | `"200-399"` | no |
| health\_check\_path | The destination for the health check request | `string` | `"/"` | no |
| health\_check\_port | The port to use for the healthcheck | `string` | `"traffic-port"` | no |
| health\_check\_timeout | The amount of time to wait in seconds before failing a health check request | `number` | `10` | no |
| health\_check\_unhealthy\_threshold | The number of consecutive health check failures required before considering the target unhealthy | `number` | `2` | no |
| http2\_enabled | A boolean flag to enable/disable HTTP/2 | `bool` | `true` | no |
| http\_enabled | A boolean flag to enable/disable HTTP listener | `bool` | `true` | no |
| http\_ingress\_cidr\_blocks | List of CIDR blocks to allow in HTTP security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| http\_ingress\_prefix\_list\_ids | List of prefix list IDs for allowing access to HTTP ingress security group | `list(string)` | `[]` | no |
| http\_port | The port for the HTTP listener | `number` | `80` | no |
| http\_redirect | A boolean flag to enable/disable HTTP redirect to HTTPS | `bool` | `false` | no |
| https\_enabled | A boolean flag to enable/disable HTTPS listener | `bool` | `false` | no |
| https\_ingress\_cidr\_blocks | List of CIDR blocks to allow in HTTPS security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| https\_ingress\_prefix\_list\_ids | List of prefix list IDs for allowing access to HTTPS ingress security group | `list(string)` | `[]` | no |
| https\_port | The port for the HTTPS listener | `number` | `443` | no |
| https\_ssl\_policy | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-2015-05"` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle | `number` | `60` | no |
| internal | A boolean flag to determine whether the ALB should be internal | `bool` | `false` | no |
| ip\_address\_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | `string` | `"ipv4"` | no |
| label\_key\_case | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| lifecycle\_rule\_enabled | A boolean that indicates whether the s3 log bucket lifecycle rule should be enabled. | `bool` | `false` | no |
| listener\_http\_fixed\_response | Have the HTTP listener return a fixed response for the default action. | <pre>object({<br>    content_type = string<br>    message_body = string<br>    status_code  = string<br>  })</pre> | `null` | no |
| listener\_https\_fixed\_response | Have the HTTPS listener return a fixed response for the default action. | <pre>object({<br>    content_type = string<br>    message_body = string<br>    status_code  = string<br>  })</pre> | `null` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| noncurrent\_version\_expiration\_days | Specifies when noncurrent s3 log versions expire | `number` | `90` | no |
| noncurrent\_version\_transition\_days | Specifies when noncurrent s3 log versions transition | `number` | `30` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| security\_group\_enabled | Enables the security group | `bool` | `true` | no |
| security\_group\_ids | A list of additional security group IDs to allow access to ALB | `list(string)` | `[]` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| standard\_transition\_days | Number of days to persist logs in standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| stickiness | Target group sticky configuration | <pre>object({<br>    cookie_duration = number<br>    enabled         = bool<br>  })</pre> | `null` | no |
| subnet\_ids | A list of subnet IDs to associate with ALB | `list(string)` | n/a | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| target\_group\_additional\_tags | The additional tags to apply to the target group | `map(string)` | `{}` | no |
| target\_group\_name | The name for the default target group, uses a module label name if left empty | `string` | `""` | no |
| target\_group\_port | The port for the default target group | `number` | `80` | no |
| target\_group\_protocol | The protocol for the default target group HTTP or HTTPS | `string` | `"HTTP"` | no |
| target\_group\_target\_type | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group | `string` | `"ip"` | no |
| vpc\_id | VPC ID to associate with ALB | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_logs\_bucket\_id | The S3 bucket ID for access logs |
| alb\_arn | The ARN of the ALB |
| alb\_arn\_suffix | The ARN suffix of the ALB |
| alb\_dns\_name | DNS name of ALB |
| alb\_name | The ARN suffix of the ALB |
| alb\_zone\_id | The ID of the zone which ALB is provisioned |
| default\_target\_group\_arn | The default target group ARN |
| http\_listener\_arn | The ARN of the HTTP forwarding listener |
| http\_redirect\_listener\_arn | The ARN of the HTTP to HTTPS redirect listener |
| https\_listener\_arn | The ARN of the HTTPS listener |
| listener\_arns | A list of all the listener ARNs |
| security\_group\_id | The security group ID of the ALB |
<!-- markdownlint-restore -->
