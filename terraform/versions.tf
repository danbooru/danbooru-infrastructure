terraform {
  required_version = "1.1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.7"
    }

    linode = {
      source  = "linode/linode"
      version = "~> 1.25"
    }

    ovh = {
      source  = "ovh/ovh"
      version = "~> 0.16"
    }
  }
}
