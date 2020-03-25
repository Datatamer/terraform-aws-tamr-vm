# Tamr VM Security Groups Module
This is a terraform module for security groups for the EC2 instance where Tamr is running. These groups will allow port openings, SSH access, and related networking permissions for EC2.
This repo is laid out following the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
An inline example implementation of the module is implemented in the examples folder.
This is the most basic example of what it would look like to use this module.

```
module "aws-vm-sg" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm/modules/aws-security-groups?ref=0.1.0"
  vpc_id = "vpc-123456789"
  ingress_cidr_blocks = [
    "1.2.3.4/32",
    "0.0.0.0/0",
  ]
}
```

# Resources Created
This modules creates:
* a security group for EC2 allowing access to the Tamr VM.
* additonal security group rules By default, opens the UI and API port for Tamr,
enables HTTP on port `80`, and opens egress, which allows Tamr to operate and recreates
AWS's default ALLOW ALL egress rules. These ports can be changed if desired. Additional
ports for basic monitoring (Kibana and Grafana), as well as TLS, SSH, and ping,
can be enabled using boolean variables. Additional rules can be added manually.

# Variables
## Inputs
* `vpc_id` (required): The ID of the VPC where the security group will be created.
* `sg_name` (optional): The name to give the new security group. Defaults to `tamr-instance-security-group`.
* `tamr_port` (optional): The port that Tamr is using for UI access and API proxying. Defaults to `9100`.
* `kibana_port` (optional): The port for Kibana acess. Defaults to `5601`.
* `enable_kibana_port` (optional): A boolean for whether to open the Kibana port. Defaults to `true`.
* `grafana_port` (optional): The port for Grafana acess. Defaults to `31101`.
* `enable_grafana_port` (optional): A boolean for whether to open the Grafana port. Defaults to `true`.
* `enable_tls` (optional): A boolean for whether to enable TLS on port `443`. Defaults to `true`.
* `enable_ssh` (optional): A boolean for whether to enable SSH access on port `22`. Defaults to `true`.
* `enable_ping` (optional): A boolean for whether to enable ping using `ICMP`. Defaults to `true`.
* `ingress_cidr_blocks` (optional): A list of CIDR blocks to allow for inbound access. Defaults to `[]`, but must include a CIDR block that describes your VPC or local IP or Tamr will be inaccessible to you.
* `egress_cidr_blocks` (optional): A list of CIDR blocks to allow for outbound access. Defaults to `["0.0.0.0/0"]` to allow services to talk to one another via the network loopback interface.
* `additional_tags` (optional): Additional tags for the security.

## Outputs
* `tamr_security_group_id`: ID for the security group created

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
