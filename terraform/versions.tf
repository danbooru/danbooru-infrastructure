terraform {
  required_version = "1.0.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }

    linode = {
      source  = "linode/linode"
      version = "1.16.0"
    }

    ovh = {
      source  = "ovh/ovh"
      version = "0.11.0"
    }
  }
}
