![Cloud Posse](https://cloudposse.com/logo-300x69.png)

# terraform-aws-alb [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-alb.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-alb)

A Terraform module to create an ALB, default ALB listener(s), and a default ALB target and related security groups.

## Usage

## Inputs

| Name                               |    Default      | Description                                                                      | Required |
|:-----------------------------------|:---------------:|:---------------------------------------------------------------------------------|:--------:|
| `namespace`                        |      ``         | Namespace (e.g. `cp` or `cloudposse`)                                            |   Yes    |
| `stage`                            |      ``         | Stage (e.g. `prod`, `dev`, `staging`)                                            |   Yes    |
| `name`                             |      ``         | Name  (e.g. `app` or `cluster`)                                                  |   Yes    |
| `vpc_id`                           |      ``         | The VPC ID where ALB will be provisioned                                         |   Yes    |
| `subnet_ids`                       |      ``         | A list of subnet IDs to associate with ALB                                       |   Yes    |
| `enabled`                          |    `true`       | A boolean flag to enable/disable resource creation.                              |    No    |
| `security_group_ids`               |     `[]`        | A list of additional security group IDs to allow access to ALB                   |    No    |
| `internal`                         |    `false`      | A boolean flag to determine whether the ALB should be internal                   |    No    |
| `http_port`                        |     `80`        | The port for the HTTP listener                                                   |    No    |
| `http_enabled`                     |     `true`      | A boolean flag to enable/disable HTTP listener                                   |    No    |
| `http_ingress_cidr_blocks`         | `["0.0.0.0/0"]` | List of CIDR blocks to allow into HTTP security group                            |    No    |
| `http_ingress_prefix_list_ids`     |      `[]`       | List of prefix list IDs for allowing access to HTTP ingress security group       |    No    |
| `certificate_arn`                  |      ``         | The ARN of the default SSL certificate for HTTPS listener                        |    No    |
| `https_port`                       |     `443`       | The port for the HTTPS listener                                                  |    No    |
| `https_enabled`                    |    `false`      | A boolean flag to enable/disable HTTPS listener                                  |    No    |
| `https_ingress_cidr_blocks`        | `["0.0.0.0/0"]` | List of CIDR blocks to allow into HTTPS security group                           |    No    |
| `https_ingress_prefix_list_ids`    |      `[]`       | List of prefix list IDs for allowing access to HTTPS ingress security group      |    No    |
| `access_logs_prefix`               |      ``         | The S3 bucket prefix                                                             |    No    |
| `access_logs_enabled`              |    `true`       | A boolean flag to enable/disable access_logs                                     |    No    |
| `access_logs_region`               |  `us-east-1`    | The region for the access_logs S3 bucket                                         |    No    |
| `http2_enabled`                    |    `true`       | A boolean flag to enable/disable HTTP/2                                          |    No    |
| `idle_timeout`                     |     `60`        | The time in seconds that the connection is allowed to be idle                    |    No    |
| `ip_address_type`                  |    `ipv4`       | The type of IP addresses used by the subnets (`ipv4` or `dualstack`)             |    No    |
| `deletion_protection_enabled`      |    `false`      | A boolean flag to enable/disable deletion protection for ALB                     |    No    |
| `deregistration_delay`             |     `15`        | The amount of time to wait in seconds before changing deregistering target       |    No    |
| `health_check_path`                |     `/`         | The destination for the health check request                                     |    No    |
| `health_check_timeout`             |     `10`        | The amount of time to wait in seconds before failing a health check request      |    No    |
| `health_check_healthy_threshold`   |     `2`         | The number of consecutive health checks successes required before healthy        |    No    |
| `health_check_unhealthy_threshold` |     `2`         | The number of consecutive health check failures required before unhealthy        |    No    |
| `health_check_interval`            |     `15`        | The duration in seconds in between health checks                                 |    No    |
| `health_check_matcher`             |   `200-399`     | The HTTP response codes to indicate a healthy check                              |    No    |
| `attributes`                       |     `[]`        | Additional attributes (e.g. `1`)                                                 |    No    |
| `tags`                             |     `{}`        | Additional tags  (e.g. `map("BusinessUnit","XYZ")`                               |    No    |
| `delimiter`                        |     `-`         | Delimiter to be used between `namespace`, `stage`, `name` and `attributes`       |    No    |



## Outputs

| Name                            | Description                                                     |
|:--------------------------------|:----------------------------------------------------------------|
| `alb_arn`                       | The ARN of the ALB                                              |
| `alb_arn_suffix`                | The ARN suffix of the ALB                                       |
| `alb_dns_name`                  | DNS name of ALB                                                 |
| `alb_zone_id`                   | The ID of the zone which ALB is provisioned                     |
| `security_group_id`             | The security group ID of the ALB                                |
| `default_target_group_arn`      | The default target group ARN                                    |
| `http_listener_arn`             | The ARN of the HTTP listener                                    |
| `https_listener_arn`            | The ARN of the HTTPS listener                                   |
| `listener_arns`                 | A list of all the listener ARNs                                 |
| `access_logs_bucket`            | The S3 bucket ID for access logs                                |

## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-alb/issues), send us an [email](mailto:hello@cloudposse.com) or reach out to us on [Gitter](https://gitter.im/cloudposse/).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-alb/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing `terraform-aws-alb`, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!

## License

[APACHE 2.0](LICENSE) © 2018 [Cloud Posse, LLC](https://cloudposse.com)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

## About

This project is maintained and funded by [Cloud Posse, LLC][website].

![Cloud Posse](https://cloudposse.com/logo-300x69.png)


Like it? Please let us know at <hello@cloudposse.com>

We love [Open Source Software](https://github.com/cloudposse/)!

See [our other projects][community]
or [hire us][hire] to help build your next cloud platform.

  [website]: https://cloudposse.com/
  [community]: https://github.com/cloudposse/
  [hire]: https://cloudposse.com/contact/


## Contributors

| [![Erik Osterman][erik_img]][erik_web]<br/>[Erik Osterman][erik_web] | [![Andriy Knysh][andriy_img]][andriy_web]<br/>[Andriy Knysh][andriy_web] |[![Igor Rodionov][igor_img]][igor_web]<br/>[Igor Rodionov][igor_img]|[![Sarkis Varozian][sarkis_img]][sarkis_web]<br/>[Sarkis Varozian][sarkis_web] |
|-------------------------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------|

[erik_img]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144
[erik_web]: https://github.com/osterman/
[andriy_img]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144
[andriy_web]: https://github.com/aknysh/
[igor_img]: http://s.gravatar.com/avatar/bc70834d32ed4517568a1feb0b9be7e2?s=144
[igor_web]: https://github.com/goruha/
[sarkis_img]: https://avatars3.githubusercontent.com/u/42673?s=144&v=4
[sarkis_web]: https://github.com/sarkis/