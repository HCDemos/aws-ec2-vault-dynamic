terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.6.0"
    }
  }
}

provider "vault" {
  // skip_child_token must be explicitly set to true as HCP Terraform manages the token lifecycle
  //skip_child_token = true
  address          = var.tfc_vault_address
  namespace        = var.tfc_vault_namespace

//  auth_login_token_file {
//    filename = var.tfc_vault_dynamic_credentials.default.token_filename
//  }
}

# ask Vault to get credentials to use for deployment to AWS
data "vault_aws_access_credentials" "aws_creds" {
  backend = "aws"
  role     = "my-role"
  type     = "iam_user"
}

# configure provider to use Vault's dynamically generated credentials for AWS
provider "aws" {
  region = var.aws_region
  access_key = sensitive("${data.vault_aws_access_credentials.aws_creds.access_key}")
  secret_key = sensitive("${data.vault_aws_access_credentials.aws_creds.secret_key}")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count         = 1
  tags = {
    name = "${var.prefix}-vpc-${var.region}"
    owner = var.prefix
    region = var.hashi-region
    purpose = var.purpose
    ttl = var.ttl
    Department = var.Department
    Billable = var.Billable
  }
}

