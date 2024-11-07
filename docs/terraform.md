<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_logs"></a> [access\_logs](#module\_access\_logs) | cloudposse/lb-s3-bucket/aws | 0.19.0 |
| <a name="module_default_load_balancer_label"></a> [default\_load\_balancer\_label](#module\_default\_load\_balancer\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_default_target_group_label"></a> [default\_target\_group\_label](#module\_default\_target\_group\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.http_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.https_sni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_target_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_enabled"></a> [access\_logs\_enabled](#input\_access\_logs\_enabled) | A boolean flag to enable/disable access\_logs | `bool` | `true` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | The S3 log bucket prefix | `string` | `""` | no |
| <a name="input_access_logs_s3_bucket_id"></a> [access\_logs\_s3\_bucket\_id](#input\_access\_logs\_s3\_bucket\_id) | An external S3 Bucket name to store access logs in. If specified, no logging bucket will be created. | `string` | `null` | no |
| <a name="input_additional_certs"></a> [additional\_certs](#input\_additional\_certs) | A list of additonal certs to add to the https listerner | `list(string)` | `[]` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_alb_access_logs_s3_bucket_force_destroy"></a> [alb\_access\_logs\_s3\_bucket\_force\_destroy](#input\_alb\_access\_logs\_s3\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| <a name="input_allow_ssl_requests_only"></a> [allow\_ssl\_requests\_only](#input\_allow\_ssl\_requests\_only) | Set to true to require requests to use Secure Socket Layer (HTTPS/SSL) on the access logs S3 bucket. This will explicitly deny access to HTTP requests | `bool` | `false` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the default SSL certificate for HTTPS listener | `string` | `""` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_cross_zone_load_balancing_enabled"></a> [cross\_zone\_load\_balancing\_enabled](#input\_cross\_zone\_load\_balancing\_enabled) | A boolean flag to enable/disable cross zone load balancing | `bool` | `true` | no |
| <a name="input_default_target_group_enabled"></a> [default\_target\_group\_enabled](#input\_default\_target\_group\_enabled) | Whether the default target group should be created or not. | `bool` | `true` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | A boolean flag to enable/disable deletion protection for ALB | `bool` | `false` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time to wait in seconds before changing the state of a deregistering target to unused | `number` | `15` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). | `bool` | `false` | no |
| <a name="input_enable_glacier_transition"></a> [enable\_glacier\_transition](#input\_enable\_glacier\_transition) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Enables the transition to AWS Glacier which can cause unnecessary costs for huge amount of small files | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Number of days after which to expunge the objects | `number` | `90` | no |
| <a name="input_glacier_transition_days"></a> [glacier\_transition\_days](#input\_glacier\_transition\_days) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Number of days after which to move the data to the Glacier Flexible Retrieval storage tier | `number` | `60` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The duration in seconds in between health checks | `number` | `15` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | The HTTP response codes to indicate a healthy check | `string` | `"200-399"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination for the health check request | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port to use for the healthcheck | `string` | `"traffic-port"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol to use for the healthcheck. If not specified, same as the traffic protocol | `string` | `null` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The amount of time to wait in seconds before failing a health check request | `number` | `10` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | The number of consecutive health check failures required before considering the target unhealthy | `number` | `2` | no |
| <a name="input_http2_enabled"></a> [http2\_enabled](#input\_http2\_enabled) | A boolean flag to enable/disable HTTP/2 | `bool` | `true` | no |
| <a name="input_http_enabled"></a> [http\_enabled](#input\_http\_enabled) | A boolean flag to enable/disable HTTP listener | `bool` | `true` | no |
| <a name="input_http_ingress_cidr_blocks"></a> [http\_ingress\_cidr\_blocks](#input\_http\_ingress\_cidr\_blocks) | List of CIDR blocks to allow in HTTP security group | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_http_ingress_prefix_list_ids"></a> [http\_ingress\_prefix\_list\_ids](#input\_http\_ingress\_prefix\_list\_ids) | List of prefix list IDs for allowing access to HTTP ingress security group | `list(string)` | `[]` | no |
| <a name="input_http_port"></a> [http\_port](#input\_http\_port) | The port for the HTTP listener | `number` | `80` | no |
| <a name="input_http_redirect"></a> [http\_redirect](#input\_http\_redirect) | A boolean flag to enable/disable HTTP redirect to HTTPS | `bool` | `false` | no |
| <a name="input_https_enabled"></a> [https\_enabled](#input\_https\_enabled) | A boolean flag to enable/disable HTTPS listener | `bool` | `false` | no |
| <a name="input_https_ingress_cidr_blocks"></a> [https\_ingress\_cidr\_blocks](#input\_https\_ingress\_cidr\_blocks) | List of CIDR blocks to allow in HTTPS security group | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_https_ingress_prefix_list_ids"></a> [https\_ingress\_prefix\_list\_ids](#input\_https\_ingress\_prefix\_list\_ids) | List of prefix list IDs for allowing access to HTTPS ingress security group | `list(string)` | `[]` | no |
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | The port for the HTTPS listener | `number` | `443` | no |
| <a name="input_https_ssl_policy"></a> [https\_ssl\_policy](#input\_https\_ssl\_policy) | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-2015-05"` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The time in seconds that the connection is allowed to be idle | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | A boolean flag to determine whether the ALB should be internal | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | `string` | `"ipv4"` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_lifecycle_configuration_rules"></a> [lifecycle\_configuration\_rules](#input\_lifecycle\_configuration\_rules) | A list of S3 bucket v2 lifecycle rules, as specified in [terraform-aws-s3-bucket](https://github.com/cloudposse/terraform-aws-s3-bucket)"<br/>These rules are not affected by the deprecated `lifecycle_rule_enabled` flag.<br/>**NOTE:** Unless you also set `lifecycle_rule_enabled = false` you will also get the default deprecated rules set on your bucket. | <pre>list(object({<br/>    enabled = bool<br/>    id      = string<br/><br/>    abort_incomplete_multipart_upload_days = number<br/><br/>    # `filter_and` is the `and` configuration block inside the `filter` configuration.<br/>    # This is the only place you should specify a prefix.<br/>    filter_and = any<br/>    expiration = any<br/>    transition = list(any)<br/><br/>    noncurrent_version_expiration = any<br/>    noncurrent_version_transition = list(any)<br/>  }))</pre> | `[]` | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | DEPRECATED: Defaults to `false`, use `lifecycle_configuration_rules` instead.<br/>When `true`, configures lifecycle events on this bucket using individual (now deprecated) variables." | `bool` | `false` | no |
| <a name="input_listener_additional_tags"></a> [listener\_additional\_tags](#input\_listener\_additional\_tags) | The additional tags to apply to all listeners | `map(string)` | `{}` | no |
| <a name="input_listener_http_fixed_response"></a> [listener\_http\_fixed\_response](#input\_listener\_http\_fixed\_response) | Have the HTTP listener return a fixed response for the default action. | <pre>object({<br/>    content_type = string<br/>    message_body = string<br/>    status_code  = string<br/>  })</pre> | `null` | no |
| <a name="input_listener_https_fixed_response"></a> [listener\_https\_fixed\_response](#input\_listener\_https\_fixed\_response) | Have the HTTPS listener return a fixed response for the default action. | <pre>object({<br/>    content_type = string<br/>    message_body = string<br/>    status_code  = string<br/>  })</pre> | `null` | no |
| <a name="input_listener_https_redirect"></a> [listener\_https\_redirect](#input\_listener\_https\_redirect) | Have the HTTPS listener return a redirect response for the default action. | <pre>object({<br/>    host        = optional(string)<br/>    path        = optional(string)<br/>    port        = optional(string)<br/>    protocol    = optional(string)<br/>    query       = optional(string)<br/>    status_code = string<br/>  })</pre> | <pre>{<br/>  "host": null,<br/>  "path": null,<br/>  "port": null,<br/>  "protocol": null,<br/>  "query": null,<br/>  "status_code": "HTTP_301"<br/>}</pre> | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | The name for the default load balancer, uses a module label name if left empty | `string` | `""` | no |
| <a name="input_load_balancer_name_max_length"></a> [load\_balancer\_name\_max\_length](#input\_load\_balancer\_name\_max\_length) | The max length of characters for the load balancer. | `number` | `32` | no |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups | `string` | `"round_robin"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_noncurrent_version_expiration_days"></a> [noncurrent\_version\_expiration\_days](#input\_noncurrent\_version\_expiration\_days) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Specifies when non-current object versions expire (in days) | `number` | `90` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Specifies (in days) when noncurrent object versions transition to Glacier Flexible Retrieval | `number` | `30` | no |
| <a name="input_preserve_host_header"></a> [preserve\_host\_header](#input\_preserve\_host\_header) | Indicates whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change. | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_security_group_enabled"></a> [security\_group\_enabled](#input\_security\_group\_enabled) | Enables the security group | `bool` | `true` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of additional security group IDs to allow access to ALB | `list(string)` | `[]` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | The amount of time (30-900 seconds) until a healthy target receives its full share of requests from the load balancer. 0 to disable. | `number` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_standard_transition_days"></a> [standard\_transition\_days](#input\_standard\_transition\_days) | (Deprecated, use `lifecycle_configuration_rules` instead)<br/>Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | Target group sticky configuration | <pre>object({<br/>    cookie_duration = number<br/>    enabled         = bool<br/>  })</pre> | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to associate with ALB | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_target_group_additional_tags"></a> [target\_group\_additional\_tags](#input\_target\_group\_additional\_tags) | The additional tags to apply to the target group | `map(string)` | `{}` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name for the default target group, uses a module label name if left empty | `string` | `""` | no |
| <a name="input_target_group_name_max_length"></a> [target\_group\_name\_max\_length](#input\_target\_group\_name\_max\_length) | The max length of characters for the target group. | `number` | `32` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | The port for the default target group | `number` | `80` | no |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | The protocol for the default target group HTTP or HTTPS | `string` | `"HTTP"` | no |
| <a name="input_target_group_protocol_version"></a> [target\_group\_protocol\_version](#input\_target\_group\_protocol\_version) | The protocol version for the default target group HTTP1 or HTTP2 or GRPC | `string` | `"HTTP1"` | no |
| <a name="input_target_group_target_type"></a> [target\_group\_target\_type](#input\_target\_group\_target\_type) | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group | `string` | `"ip"` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to associate with ALB | `string` | n/a | yes |
| <a name="input_xff_header_processing_mode"></a> [xff\_header\_processing\_mode](#input\_xff\_header\_processing\_mode) | Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target. The possible values are append, preserve, and remove. Only valid for Load Balancers of type application. The default is append | `string` | `"append"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_logs_bucket_id"></a> [access\_logs\_bucket\_id](#output\_access\_logs\_bucket\_id) | The S3 bucket ID for access logs |
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the ALB |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | The ARN suffix of the ALB |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of ALB |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | The ARN suffix of the ALB |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | The ID of the zone which ALB is provisioned |
| <a name="output_default_target_group_arn"></a> [default\_target\_group\_arn](#output\_default\_target\_group\_arn) | The default target group ARN |
| <a name="output_default_target_group_arn_suffix"></a> [default\_target\_group\_arn\_suffix](#output\_default\_target\_group\_arn\_suffix) | The default target group ARN suffix |
| <a name="output_http_listener_arn"></a> [http\_listener\_arn](#output\_http\_listener\_arn) | The ARN of the HTTP forwarding listener |
| <a name="output_http_redirect_listener_arn"></a> [http\_redirect\_listener\_arn](#output\_http\_redirect\_listener\_arn) | The ARN of the HTTP to HTTPS redirect listener |
| <a name="output_https_listener_arn"></a> [https\_listener\_arn](#output\_https\_listener\_arn) | The ARN of the HTTPS listener |
| <a name="output_listener_arns"></a> [listener\_arns](#output\_listener\_arns) | A list of all the listener ARNs |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the ALB |
<!-- markdownlint-restore -->
