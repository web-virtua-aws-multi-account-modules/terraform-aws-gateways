# AWS NAT gateway and internet gateway for multiples accounts and regions with Terraform module
* This module simplifies creating and configuring NAT gateway and internet gateway across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.3.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enable of security groups configurations for this module:

- Internet gateway
- Nat gateway public or private

## Usage exemples

### Internet gateway

```hcl
module "internet_gateway_test" {
  source       = "web-virtua-aws-multi-account-modules/gateways/aws"
  name         = "tf-internet-gateway-test"
  vpc_id       = aws_vpc.main.id
  gateway_type = "internet"

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Nat gateway private

```hcl
module "nat_gateway_private_test" {
  source            = "web-virtua-aws-multi-account-modules/gateways/aws"
  name              = "tf-nat-gateway-private-test"
  gateway_type      = "nat"
  subnet_id         = aws_subnet.main.id
  connectivity_type = "private"

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Nat gateway public

```hcl
module "nat_gateway_public_test" {
  source       = "web-virtua-aws-multi-account-modules/gateways/aws"
  name         = "tf-nat-gateway-public-test"
  gateway_type = "nat"
  subnet_id    = aws_subnet.main.id

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Nat gateway public and internet gateway in the same module
* In this case, the name variable defined as both will receive the prefix -igtw to internet gateway and -ngtw to nat gateway at the end of the string

```hcl
module "nat_gtw_public_and_internet_gtw_test" {
  source       = "web-virtua-aws-multi-account-modules/gateways/aws"
  name         = "tf-gateway-test"
  gateway_type = "both"
  vpc_id       = aws_vpc.main.id 
  subnet_id    = aws_subnet.main.id

  providers = {
    aws = aws.alias_profile_a
  }
}
```


## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `null` | no | Name to gateway used in tags, if not defined will be used tf-internet-gateway to igtw or tf-nat-gateway to ngtw | `-` |
| vpc_id | `string` | `null` | no | VPC ID to gateway | `-` |
| gateway_type | `string` | `internet` | no | Gateway type, can be internet, nat or both | `*`internet <br> `*`nat<br> `*`both |
| connectivity_type | `string` | `public` | no | Connectivity type to nat gateway, can be public or private, if connectivity type setup as public will be created static ip to Nat gateway | `-` |
| private_ip_id | `string` | `null` | no | Private IP ID to allocation in nat gateway, if null a private IPv4 address will be automatically assigned | `-` |
| subnet_id | `string` | `null` | no | Subnet ID to nat gateway | `-` |
| tags | `map(any)` | `{}` | no | Tags to gateways | `-` |
| tags_eip | `map(any)` | `{}` | no | Tags to Elastic IP | `-` |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.create_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.create_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_eip.create_static_ip_nat_allocation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |


## Outputs

| Name | Description |
|------|-------------|
| `internet_gateway` | All informations of the internet gateway |
| `internet_gateway_id` | Internet gateway ID |
| `internet_gateway_arn` | Internet gateway ARN |
| `nat_gateway` | All informations of the NAT gateway |
| `nat_gateway_id` | NAT gateway ID |
| `nat_gateway_elastic_ip` | All informations of the IP nat allocation |
