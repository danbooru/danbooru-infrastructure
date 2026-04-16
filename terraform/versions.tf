terraform {
  required_version = "1.14.8"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.19.0-beta.5"
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
