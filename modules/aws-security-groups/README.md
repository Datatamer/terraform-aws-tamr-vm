# Tamr VM Security Groups Module
This module returns a list of ports used by the Tamr software.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "aws-vm-sg" {
  source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=x.y.z"
}
```

# Resources Created
This module creates no resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_ports | Additional ports that should be added to the output of this module | `list(number)` | `[]` | no |
| ports | Ports used by the Tamr software | `list(number)` | <pre>[<br>  22,<br>  9100,<br>  9200,<br>  9020,<br>  9080,<br>  21281,<br>  5601,<br>  31101<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_ports | List of ingress ports |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
